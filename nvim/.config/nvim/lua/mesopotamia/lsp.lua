local api = vim.api
local map = vim.keymap.set

local setup = function()
  require("neodev").setup({})
  local lsp_config = require("lspconfig")

  local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

  local on_attach = function(client, bufnr)
    map("n", "gD", vim.lsp.buf.definition)
    map("n", "gtD", vim.lsp.buf.type_definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "<leader>sh", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("v", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>cl", vim.lsp.codelens.run)
    map("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)
    map("n", "<leader>h", function()
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      else
        vim.notify("Server is not an inlayhint provider", vim.log.levels.ERROR)
      end
    end)

    map("n", "<leader>o", function()
      vim.lsp.buf.format({ async = true })
    end)

    api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
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

  --metals_config.cmd = { "cs", "launch", "tech.neader:langoustine-tracer_3:0.0.18", "--", "metals" }
  metals_config.settings = {
    --bloopVersion = "1.5.6-253-5faffd8d-SNAPSHOT",
    --disabledMode = true,
    defaultBspToBuildTool = true,
    enableSemanticHighlighting = false,
    inlayHints = {
      hintsInPatternMatch = { enable = true },
      implicitArguments = { enable = true },
      implicitConversions = { enable = true },
      inferredTypes = { enable = true },
      typeParameters = { enable = true },

    },
    serverVersion = "latest.snapshot",
    --serverVersion = "1.4.2-SNAPSHOT",
    --testUserInterface = "Test Explorer"
  }

  metals_config.init_options = {
    statusBarProvider = "off",
    icons = "unicode"
  }

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
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
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
      {
        type = "scala",
        request = "launch",
        name = "Run minimal2 main",
        metals = {
          mainClass = "minimal2.Main",
          buildTarget = "minimal",
        },
      },
    }

    map("n", "<leader>dc", require("dap").continue)
    map("n", "<leader>dr", require("dap").repl.toggle)
    map("n", "<leader>dK", require("dap.ui.widgets").hover)
    map("n", "<leader>dtb", require("dap").toggle_breakpoint)
    map("n", "<leader>dso", require("dap").step_over)
    map("n", "<leader>dsi", require("dap").step_into)
    map("n", "<leader>drl", require("dap").run_last)

    map("n", "<leader>dtc", function()
      require("dap").toggle_breakpoint("x == 3")
    end)

    dap.listeners.after["event_terminated"]["nvim-metals"] = function()
      vim.notify("dap finished!")
      --dap.repl.open()
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

  api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.worksheet.sc" },
    callback = function()
      vim.lsp.inlay_hint.enable(true)
    end,
    group = nvim_metals_group,
  })

  -- For editing tree-sitter grammars
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "grammar.js", "corpus/*.txt" },
    callback = function()
      vim.cmd("setfiletype tree-sitter-grammar")
    end,
  })

  vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "grammar.js" },
    command = "set syntax=javascript",
  })

  lsp_config.lua_ls.setup({
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
        diagnostics = { globals = { "vim", "it", "describe", "before_each" } },
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
    on_attach = on_attach,
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/oyvindberg/bleep/master/schema.json"] = "bleep.yaml",
        },
      },
    },
  })

  -- These server just use the vanilla setup
  local servers = { "bashls", "dockerls", "html", "ts_ls", "gopls", "pyright" }
  for _, server in pairs(servers) do
    lsp_config[server].setup({ on_attach = on_attach })
  end

  -- Uncomment for trace logs from neovim
  -- vim.lsp.set_log_level('trace')
end

return {
  setup = setup,
}
