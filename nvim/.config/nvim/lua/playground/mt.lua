local Job = require("plenary.job")
local F = require("plenary.functional")

require("playground.globals")

local ongoing_completion = nil

local key_mappings = {
  choose_artifact = "<cmd>lua require('playground.mt').choose_artifact()<CR>",
  copy_version = "<cmd>lua require('playground.mt').copy_version()<CR>",
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

local Completion = {}

Completion.__index = Completion

Completion.new = function(org, artifact)
  return setmetatable({ org = org, artifact = artifact, completed = false }, Completion)
end

Completion.complete = function(self)
  local args = string.format("%s:%s", self.org, self.artifact)
  Job:new({
    command = "cs",
    args = { "complete", args },
    on_exit = function(j, return_val)
      if return_val == 0 then
        self.results = j:result()
      else
        print("Something went wrong, unable to get completions")
      end
    end,
  }):sync()
end

Completion.display = function(self)
  vim.api.nvim_buf_set_lines(self.win.bufnr, 0, -1, false, self.results)
end

Completion.set_keymap = function(self, key_map)
  vim.api.nvim_buf_set_keymap(self.win.bufnr, "n", "<CR>", key_map, { nowait = true, silent = true })
end

local function get_dep()
  -- TODO in the future handle Mill as well
  local org, artifact = vim.api.nvim_get_current_line():match('"(.+)"%s+%%?%%?%%%s+"(.+)"%s+%%.+')
  if org and artifact then
    local completion = Completion.new(org, artifact)
    completion:complete()
    -- TODO there is quite a bit of duplicaton here
    if #completion.results == 1 then
      completion.artifact = completion.artifact .. ":"
      completion:complete()
      local win = require("plenary.window.float").percentage_range_window(0.5, 0.2)
      completion.win = win
      completion:display()
      completion:set_keymap(key_mappings["copy_version"])
    else
      local win = require("plenary.window.float").percentage_range_window(0.5, 0.2)
      completion.win = win
      completion:display()
      completion:set_keymap(key_mappings["choose_artifact"])
      ongoing_completion = completion
    end
  else
    print("Unable to find a dependency on this line.")
  end
end

local choose_artifact = function()
  local line_contents = vim.api.nvim_get_current_line()
  local prev_results = ongoing_completion.results
  ongoing_completion.artifact = line_contents
  ongoing_completion:complete()
  if #ongoing_completion.results == 1 or same_results(prev_results, ongoing_completion.results) then
    ongoing_completion.artifact = ongoing_completion.artifact .. ":"
    ongoing_completion:complete()
    ongoing_completion:set_keymap(key_mappings["copy_version"])
    ongoing_completion:display()
  end
  ongoing_completion:display()
end

local copy_version = function()
  local line_contents = vim.api.nvim_get_current_line()
  vim.fn.setreg("+", line_contents)
  print("Copied version")
  vim.api.nvim_win_close(ongoing_completion.win.win, true)
end

return {
  get_dep = get_dep,
  choose_artifact = choose_artifact,
  copy_version = copy_version,
}
