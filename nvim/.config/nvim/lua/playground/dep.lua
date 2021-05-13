local Job = require("plenary.job")
local F = require("plenary.functional")

require("playground.globals")

local state = {
  results = {},
  win = nil,
  org = nil,
  artifact = nil,
  version_seperator = "",
}

local function same_results(old, new)
  if #old ~= #new then
    return false
  else
    return F.all(function(k, v)
      return old[k] == v
    end, new)
  end
end

local cs_complete = function()
  local continue = true
  local args = string.format("%s:%s%s", state.org, state.artifact, state.version_seperator)
  Job:new({
    -- TODO you have to have cs install, or else this sucks
    command = "cs",
    args = { "complete", args },
    on_exit = function(j, return_val)
      if return_val == 0 then
        local new_results = j:result()
        if same_results(state.results, new_results) or #new_results == 1 then
          continue = false
        end
        state.results = new_results
      else
        print("Something went wrong, unable to get completions")
      end
    end,
  }):sync()
  return continue
end

local function set_copy_keymap()
  vim.api.nvim_buf_set_keymap(
    state.win.bufnr,
    "n",
    "<CR>",
    "<cmd>lua require('playground.dep').copy_version()<CR>",
    { nowait = true, silent = true }
  )
end

local function set_choose_artifact_keymap()
  vim.api.nvim_buf_set_keymap(
    state.win.bufnr,
    "n",
    "<CR>",
    "<cmd>lua require('playground.dep').choose_artifact()<CR>",
    { nowait = true, silent = true }
  )
end

local function set_lines(lines)
  vim.api.nvim_buf_set_lines(state.win.bufnr, 0, -1, false, lines)
end

local function get_dep()
  -- TODO in the future handle Mill as well
  local org, artifact = vim.api.nvim_get_current_line():match('"(.+)"%s+%%?%%?%%%s+"(.+)"%s+%%.+')

  if org and artifact then
    state.org = org
    state.artifact = artifact

    local continue = cs_complete()

    if continue then
      local win = require("plenary.window.float").percentage_range_window(0.5, 0.2)
      state.win = win
      set_lines(state.results)
      set_choose_artifact_keymap()
    else
      state.version_seperator = ":"
      cs_complete()
      local win = require("plenary.window.float").percentage_range_window(0.5, 0.2)
      state.win = win
      set_lines(state.results)
      set_copy_keymap()
    end
  else
    print("Unable to find a dependency on this line.")
  end
end

local choose_artifact = function()
  local line_contents = vim.api.nvim_get_current_line()
  state.artifact = line_contents
  local continue = cs_complete()
  if continue then
    vim.api.nvim_buf_set_lines(state.win.bufnr, 0, -1, false, state.results)
  else
    state.version_seperator = ":"
    cs_complete()
    vim.api.nvim_buf_set_lines(state.win.bufnr, 0, -1, false, state.results)
    set_copy_keymap()
  end
end

local copy_version = function()
  local line_contents = vim.api.nvim_get_current_line()
  vim.fn.setreg("+", line_contents)
  print("Copied version")
  vim.api.nvim_win_close(state.win.win, true)
end

return {
  get_dep = get_dep,
  choose_artifact = choose_artifact,
  copy_version = copy_version,
}
