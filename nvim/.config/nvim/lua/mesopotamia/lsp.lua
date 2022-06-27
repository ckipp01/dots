local api = vim.api
local f = require("mesopotamia.functions")
local map = f.map

local setup = function()
  local lsp_config = require("lspconfig")
  local bare_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").update_capabilities(bare_capabilities)

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = capabilities,
  })

  local hover_config = {
    border = "single",
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, hover_config)

  local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

  local on_attach = function(client, bufnr)
    -- LSP agnostic mappings
    map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
    map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
    map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
    map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
    map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
    map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
    map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
    map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
    map("n", "<leader>o", [[<cmd>lua vim.lsp.buf.format({ async = true })<CR>]])

    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  --================================
  -- Metals specific setup
  --================================
  local metals_config = require("metals").bare_config()

  metals_config.settings = {
    --bloopJvmProperties = { "-Xss16m" },
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    --testUserInterface = "test explorer",
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
      "akka.http.javadsl",
    },
    --fallbackScalaVersion = "2.13.7",
    serverVersion = "latest.snapshot",
    --serverVersion = "0.11.2+74-7a6a65a7-SNAPSHOT",
    --serverVersion = "0.11.7-SNAPSHOT",
    --mavenScript = "/Users/ckipp/Documents/scala-workspace/spark/build/mvn"
    --ui = {
    --  worksheet_hover = hover_config,
    --},
  }

  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = capabilities

  metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- Metals specific mappings
    map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
    map("n", "<leader>ws", [[<cmd>lua require("metals").hover_worksheet()<CR>]])
    map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
    map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
    map("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])
    -- WIP trying some stuff out with this
    map("n", "<leader>td", [[<cmd>lua require("metals.test").toggle_test_view()<CR>]])

    -- A lot of the servers I use won't support document_highlight or codelens,
    -- so we juse use them in Metals
    api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd("FileType", {
      pattern = { "dap-repl" },
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
      group = lsp_group,
    })

    -- nvim-dap
    -- I only use nvim-dap with Scala, so we keep it all in here
    local dap = require("dap")

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run or test with input",
        metals = {
          runType = "runOrTestFile",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Run or Test",
        metals = {
          runType = "runOrTestFile",
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
    map("n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]])
    map("n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
    map("n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]])
    map("n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]])
    map("n", "<leader>drl", [[<cmd>lua require("dap").run_last()<CR>]])

    dap.listeners.after["event_terminated"]["nvim-metals"] = function(session, body)
      vim.notify("Tests have finished!")
      dap.repl.open()
    end

    require("metals").setup_dap()
  end

  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })

  require("rust-tools").setup({
    tools = { hover_with_actions = false },
    server = { on_attach = on_attach },
  })

  -- sumneko lua
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  lsp_config.sumneko_lua.setup({
    on_attach = on_attach,
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
          library = api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  })

  lsp_config.jsonls.setup({
    on_attach = on_attach,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  })

  -- These server just use the vanilla setup
  local servers = { "bashls", "dockerls", "html", "tsserver", "yamlls" }
  for _, server in pairs(servers) do
    lsp_config[server].setup({ on_attach = on_attach })
  end

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return {
  setup = setup,
}
