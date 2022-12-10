local api = vim.api
local map = vim.keymap.set

local setup = function()
  local lsp_config = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = capabilities,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

  local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

  local on_attach = function(client, bufnr)
    -- LSP agnostic mappings
    map("n", "gD", vim.lsp.buf.definition)
    map("n", "gtD", vim.lsp.buf.type_definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "<leader>sh", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>cl", vim.lsp.codelens.run)

    map("n", "<leader>o", function()
      vim.lsp.buf.format({ async = true })
    end)

    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  --================================
  -- Metals specific setup
  --================================
  local metals_config = require("metals").bare_config()
  metals_config.tvp = {
    icons = {
      enabled = true,
    },
  }

  --metals_config.cmd = { "cs", "launch", "tech.neader:langoustine-tracer_3:0.0.9", "--", "metals" }
  metals_config.settings = {
    --disabledMode = true,
    -- ONLY USE FOR LOCAL TESTING
    --bloopVersion = "1.5.3-15-49c6986e-20220816-2002",
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
      "akka.http.javadsl",
    },
    --fallbackScalaVersion = "2.13.10",
    serverVersion = "latest.snapshot",
    --serverVersion = "0.11.2+74-7a6a65a7-SNAPSHOT",
    --serverVersion = "0.11.10-SNAPSHOT",
    --testUserInterface = "Test Explorer",
  }

  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = capabilities

  metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    map("v", "K", require("metals").type_of_range)

    map("n", "<leader>ws", function()
      require("metals").hover_worksheet({ border = "single" })
    end)

    map("n", "<leader>tt", require("metals.tvp").toggle_tree_view)

    map("n", "<leader>tr", require("metals.tvp").reveal_in_tree)

    map("n", "<leader>mmc", require("metals").commands)

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

    map("n", "<leader>dc", require("dap").continue)
    map("n", "<leader>dr", require("dap").repl.toggle)
    map("n", "<leader>dK", require("dap.ui.widgets").hover)
    map("n", "<leader>dt", require("dap").toggle_breakpoint)
    map("n", "<leader>dso", require("dap").step_over)
    map("n", "<leader>dsi", require("dap").step_into)
    map("n", "<leader>drl", require("dap").run_last)

    dap.listeners.after["event_terminated"]["nvim-metals"] = function(session, body)
      --vim.notify("Tests have finished!")
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

  lsp_config.yamlls.setup({
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/oyvindberg/bleep/master/schema.json"] = "bleep.yaml"
        }
      }
    }
  })

  -- These server just use the vanilla setup
  local servers = { "bashls", "dockerls", "html", "tsserver", "gopls", "marksman" }
  for _, server in pairs(servers) do
    lsp_config[server].setup({ on_attach = on_attach })
  end

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return {
  setup = setup,
}
