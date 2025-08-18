local plugins = {
  require("custom.plugins.nvim-dap"),
  require("custom.plugins.nvim-dapui"),
  require("custom.plugins.fidget"),
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  require("custom.plugins.xcodebuild"),
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
    },
    config = function()
      require("copilot").setup({})
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      }
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 1, max_item_count = 5 },
        { name = "copilot",  group_index = 2, max_item_count = 2 },
        { name = "luasnip",  group_index = 2, max_item_count = 2 },
        { name = "buffer",   group_index = 2, max_item_count = 3 },
        { name = "nvim_lua", group_index = 2, max_item_count = 1 },
        { name = "path",     group_index = 2, max_item_count = 5 },
      }
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})
      require("core.utils").load_mappings("harpoon")
    end
  },
  require("custom.plugins.copilot-chat")
  -- require("custom.plugins.conform"),
  -- require("custom.plugins.claude-code")
}
return plugins
