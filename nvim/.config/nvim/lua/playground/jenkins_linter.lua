local Job = require("plenary.job")

local function validate()
  local buf_contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local user = os.getenv("JENKINS_USERNAME")
  local password = os.getenv("JENKINS_PASSWORD")
  local jenkins_url = os.getenv("JENKINS_URL")

  Job
    :new({
      command = "curl",
      args = {
        "--user", -- maybe a token as well
        user .. ":" .. password,
        "-X",
        "POST",
        "-d",
        "jenkinsfile=" .. table.concat(buf_contents, ""),
        jenkins_url, -- TODO make this a config or env variable
      },

      on_stdout = function(err, data)
        if not err then
          P(data)
        end
      end,
      on_exit = vim.schedule_wrap(function(_, status)
        if not status == 0 then
          vim.notify("Something went wrong getting version from metals site")
        else
          P("done")
        end
      end),
    })
    :start()
end

return {
  validate = validate,
}
