local Job = require("plenary.job")

local function preview_location(_, _, res)
  vim.lsp.util.preview_location(res[1])
end

local function peek()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location)
end

local ns = vim.api.nvim_create_namespace("playground")

local function set_ext()
  local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_extmark(0, ns, lnum, 0, {})
end

local function get_exts()
  local all = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
  print(vim.inspect(all))
end

local function visual_selection_range()
  --local test = vim.lsp.util.make_given_range_params()

  --local test = vim.lsp.util.make_range_params()
  local _, start_line_num, start_col_num, _ = unpack(vim.fn.getpos("'<"))
  local a = vim.api.nvim_buf_get_mark(0, "<")
  local b = vim.fn.getpos("'<")
  local b = vim.fn.getpos("'>")

  P(a)
  P(b)
  --if csrow < cerow or (csrow == cerow and cscol <= cecol) then
  --  return csrow - 1, cscol - 1, cerow - 1, cecol
  --else
  --  return cerow - 1, cecol - 1, csrow - 1, cscol
  --end
end

-- Super hacky hacky way to grab the latest snapshot version. The
-- maven-metadata.xml file is always out of sync so on the website we scrape
-- the overview html page and grab it from there. So this just grabs it from
-- the site...
local get_latest_metals = function()
  local version = {}
  Job
    :new({
      command = "curl",
      args = {
        "https://scalameta.org/metals/docs/",
      },

      on_stdout = function(err, data)
        if not err then
          table.insert(version, data)
        end
      end,
      on_exit = vim.schedule_wrap(function(_, status)
        if not status == 0 then
          vim.notify("Something went wrong getting version from metals site")
        else
          local latest = ""
          for _, value in ipairs(version) do
            if string.match(value, "SNAPSHOT") then
              latest = value
            end
          end
          local l = latest:match("</tr><tr><td>(%d.+SNAPSHOT)</td>")

          vim.fn.setreg("+", l)
          vim.notify(string.format("copied %s to your register", l))
        end
      end),
    })
    :start()
end

-- I could use vim-scriptease for this, but I don't want the full plugin to
-- only use the zS functionality. We we just take that out and give it some lua
-- love and instead of just displaying the name we call hi with it.
local function get_hl_under_cursor()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local id = vim.fn.synID(row, col + 1, 1)
  local result = vim.fn.synIDattr(id, "name")
  vim.cmd(string.format("hi %s", result))
end

return {
  get_hl_under_cursor = get_hl_under_cursor,
  peek = peek,
  set_ext = set_ext,
  get_exts = get_exts,
  get_latest_metals = get_latest_metals,
  visual_selection_range = visual_selection_range,
}
