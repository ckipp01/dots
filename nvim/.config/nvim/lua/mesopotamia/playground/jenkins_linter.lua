local Job = require("plenary.job")

local user = os.getenv("JENKINS_USERNAME")
local password = os.getenv("JENKINS_PASSWORD")
local jenkins_url = os.getenv("JENKINS_URL")
local namespace_id = vim.api.nvim_create_namespace("jenkins")

local function crumb_job()
  return Job:new({
    command = "curl",
    args = {
      "--user", -- maybe a token as well
      user .. ":" .. password,
      jenkins_url .. "/crumbIssuer/api/json",
    },
  })
end

local validate_job = vim.schedule_wrap(function(crumb_job, crumb_status)
  local args = vim.fn.json_decode(crumb_job._stdout_results)

  local uri = vim.uri_from_bufnr(0):sub(8)
  local err = {}

  return Job
    :new({
      command = "curl",
      args = {
        "--user", -- maybe a token as well
        user .. ":" .. password,
        "-X",
        "POST",
        "-H",
        "Jenkins-Crumb:" .. args.crumb,
        "-F",
        "jenkinsfile=<" .. uri,
        jenkins_url .. "/pipeline-model-converter/validate",
      },

      on_stderr = function(err, data)
        if err then
          -- TODO add in an error message here
          P(err)
        end
      end,
      on_stdout = vim.schedule_wrap(function(err, data)
        if not err then
          --WorkflowScript: 46: unexpected token: } @ line 46, column 1.
          local msg, line_str, col_str = data:match("WorkflowScript.+%d+: (.+) @ line (%d+), column (%d+).")
          if line_str and col_str then
            local line = tonumber(line_str)
            local col = tonumber(col_str)

            local d = {
              bufnr = vim.api.nvim_get_current_buf(),
              lnum = line,
              end_lnum = line,
              col = col,
              end_col = col,
              severity = vim.diagnostic.severity.ERROR,
              message = msg,
              source = "jenkins linting thing",
            }

            vim.diagnostic.set(namespace_id, vim.api.nvim_get_current_buf(), { d })
          end
          -- TODO check the output here to see if it's validated and then clear diagnostics

        else
          P("stdout err: " .. data)
        end
      end),
      on_exit = vim.schedule_wrap(function(_, status)
        if not status == 0 then
          vim.notify("Something went wrong")
        else
          P("final done")
        end
      end),
    })
    :start()
end)

local function validate()
  crumb_job():after(validate_job):start()
end

return {
  validate = validate,
}
