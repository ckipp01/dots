local cmd = vim.cmd
local f = require("mesopotamia.functions")
local map = f.map

local setup = function()
  -- LSP specific mappings
  map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
  map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
  map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
  map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
  map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
  map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
  map("n", "gds", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]])
  map("n", "gws", [[<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>]])
  map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
  map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
  map("n", "<leader>ws", [[<cmd>lua require("metals").hover_worksheet()<CR>]])
  map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]])
  map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]])
  map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]])
  map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
  map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
  map("n", "<leader>d", [[<cmd>lua vim.diagnostic.setloclist()<CR>]]) -- buffer diagnostics only
  map("n", "<leader>nd", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
  map("n", "<leader>pd", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
  map("n", "<leader>ld", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>]])
  map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
  map("n", "<leader>o", [[<cmd>lua vim.lsp.buf.formatting()<CR>]])
  map("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])

  cmd([[augroup lsp]])
  cmd([[autocmd!]])
  cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
  cmd([[autocmd FileType scala,sbt,java lua require("metals").initialize_or_attach(Metals_config)]])
  cmd([[augroup END]])

  -- used in textDocument/hightlight
  cmd([[hi! link LspReferenceText CursorColumn]])
  cmd([[hi! link LspReferenceRead CursorColumn]])
  cmd([[hi! link LspReferenceWrite CursorColumn]])

  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  })

  --================================
  -- Metals specific setup
  --================================
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
    serverVersion = "0.10.9+223-11c7c271-SNAPSHOT",
    --serverVersion = "0.10.10-SNAPSHOT"
  }

  Metals_config.init_options.statusBarProvider = "on"
  Metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  Metals_config.on_attach = function(client, bufnr)
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])

    -- nvim-dap
    -- I only use nvim-dap with Scala, so we keep it all in here
    local dap = require("dap")

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
          runType = "runOrTestFile",
          --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
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

    map("n", "<leader>dc", [[<cmd>lua require("dap").continue()<CR>]])
    map("n", "<leader>dr", [[<cmd>lua require("dap").repl.toggle()<CR>]])
    map(
      "n",
      "<leader>ds",
      [[<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).toggle()<CR>]]
    )
    map("n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]])
    map("n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
    map("n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]])
    map("n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]])
    map("n", "<leader>dl", [[<cmd>lua require("dap").run_last()<CR>]])

    require("metals").setup_dap()
  end

  -- sumneko lua
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  lsp_config.sumneko_lua.setup({
    cmd = {
      "/Users/ckipp/Documents/lua-workspace/lua-language-server/bin/lua-language-server",
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
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = { globals = { "vim", "it", "describe", "before_each" } },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
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

return {
  setup = setup,
}
