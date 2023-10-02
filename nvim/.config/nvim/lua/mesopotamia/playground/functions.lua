local Job = require("plenary.job")
local Path = require("plenary.path")

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

local starts_with = function(text, prefix)
  return text:find(prefix, 1, true) == 1
end

local get_java_version = function()
  local java_home = os.getenv("JAVA_HOME")
  local release = Path:new(java_home, "release")
  local version_line
  for line in io.lines(release.filename) do
    if starts_with(line, "JAVA_VERSION") then
      version_line = line
      break
    end
  end

  local version = vim.version.parse(version_line:sub(14, version_line:len()))
  return version
end

return {
  peek = peek,
  get_java_version = get_java_version,
  get_latest_metals = get_latest_metals,
}
