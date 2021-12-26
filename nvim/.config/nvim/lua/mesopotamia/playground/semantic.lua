local fn = vim.fn
local uv = vim.loop
local api = vim.api

local M = {}

local has_bins = function(...)
  for i = 1, select("#", ...) do
    if 0 == fn.executable((select(i, ...))) then
      return false
    end
  end
  return true
end

local is_windows = uv.os_uname().version:match("Windows")
local path_sep = is_windows and "\\" or "/"

local function path_join(...)
  local result = table.concat(vim.tbl_flatten({ ... }), path_sep):gsub(path_sep .. "+", path_sep)
  return result
end

local metac = "metac"
local metap = "metap"
local semantic_cache_dir = fn.stdpath("cache")

M.generate = function()
  if not has_bins(metac, metap) then
    print("Make sure you got the goods")
  else
    local current_file = vim.fn.expand("%")
    local root_name = vim.fn.expand("%:r")

    local create_cmd = string.format("%s -d %s %s", metac, semantic_cache_dir, current_file)
    local created = fn.system(create_cmd)
    if not (created == "") then
      print("Couldn't create semanticdb")
    else
      local semanticdb_path = path_join(semantic_cache_dir, "META-INF", "semanticdb", root_name .. ".scala.semanticdb")
      local cmd = string.format("%s %s", metap, semanticdb_path)
      local output = fn.systemlist(cmd)

      local buf = api.nvim_create_buf(false, false)

      local current_window = api.nvim_get_current_win()

      vim.cmd("vsplit")
      vim.cmd(string.format("buffer %d", buf))

      api.nvim_win_set_option(0, "spell", false)
      api.nvim_win_set_option(0, "number", false)
      api.nvim_win_set_option(0, "relativenumber", false)
      api.nvim_win_set_option(0, "cursorline", false)

      api.nvim_buf_set_lines(buf, 0, 0, false, output)
    end
  end
end

return M
