local M = {}

M.setup = function()
  local shared_diagnostic_settings = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    handlers = {
      ["textDocument/publishDiagnostics"] = shared_diagnostic_settings,
    },
    capabilities = capabilities,
  })

  Metals_config = require("metals").bare_config

  Metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
    },
    fallbackScalaVersion = "3.0.1",
    --fallbackScalaVersion = "2.13.6",
    superMethodLensesEnabled = true,
  }

  Metals_config.init_options.statusBarProvider = "on"
  Metals_config.handlers["textDocument/publishDiagnostics"] = shared_diagnostic_settings
  Metals_config.capabilities = capabilities

  local dap = require("dap")

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run",
      metals = {
        runType = "run",
        args = { "firstArg", "secondArg", "thirdArg" },
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

    vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
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
        diagnostics = { globals = { "vim", "it", "describe" } },
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

  require("lspconfig").kotlin_language_server.setup({
    cmd = {
      "/Users/ckipp/Documents/kotlin-workspace/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
    },
  })

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return M
