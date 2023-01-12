local Job = require("plenary.job")

local function preview_location(_, _, res)
  vim.lsp.util.preview_location(res[1])
end

local function peek()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location)
end

local get_latest_metals = function()
  Job:new({
    command = "curl",
    args = {
      "-s",
      "https://scalameta.org/metals/latests.json",
    },
    on_exit = vim.schedule_wrap(function(self, status)
      if not status == 0 then
        vim.notify("Something went wrong getting version from metals site")
      else
        local versions = vim.fn.json_decode(table.concat(self._stdout_results, ""))
        local latest_snapshot = versions.snapshot
        vim.fn.setreg("+", latest_snapshot)
        vim.notify(string.format("copied %s to your register", latest_snapshot))
      end
    end),
  }):start()
end

return {
  peek = peek,
  get_latest_metals = get_latest_metals,
}
