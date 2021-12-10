local M = {}

M.setup = function()
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  })

  Metals_config = require("metals").bare_config()

  Metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
    },
    fallbackScalaVersion = "2.13.7",
    serverVersion = "0.10.9+132-de70f264-SNAPSHOT"
  }

  Metals_config.init_options.statusBarProvider = "on"
  Metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local dap = require("dap")

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run",
      metals = {
        runType = "run",
        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = {
        runType = "runOrTestFile"
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test File",
      metals = {
        runType = "testFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }

  Metals_config.on_attach = function(client, bufnr)
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])

    require("metals").setup_dap()
  end

  -- sumneko lua
  lsp_config.sumneko_lua.setup({
    cmd = {
      "/Users/ckipp/Documents/lua-workspace/lua-language-server/bin/macOS/lua-language-server",
      "-E",
      "/Users/ckipp/Documents/lua-workspace/lua-language-server/main.lua",
    },
    commands = {
      Format = {
        function()
          require("stylua-nvim").format_file()
        end,
      },
    },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- since using mainly for neovim
          path = vim.split(package.path, ";"),
        },
        diagnostics = { globals = { "vim", "it", "describe", "before_each" } },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  })

  lsp_config.dockerls.setup({})
  lsp_config.html.setup({})
  lsp_config.jsonls.setup({
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  })
  lsp_config.tsserver.setup({})
  lsp_config.yamlls.setup({})
  lsp_config.racket_langserver.setup({})

  lsp_config.gopls.setup({
    cmd = { "gopls", "serve" },
    settings = {
      gopls = { analyses = { unusedparams = true }, staticcheck = true },
    },
  })

  lsp_config.elmls.setup({})

  lsp_config.groovyls.setup({
    cmd = {
      "java",
      "-jar",
      "/Users/ckipp/Documents/java-workspace/groovy-language-server/build/libs/groovy-language-server-all.jar",
    },
  })

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return M
