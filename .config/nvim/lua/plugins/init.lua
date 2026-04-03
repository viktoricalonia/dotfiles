return {
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  require "custom.plugins.lualine",
  require "custom.plugins.nvim-dap",
  require "custom.plugins.nvim-dapui",
  require "custom.plugins.fidget-nvim",
  require "custom.plugins.xcodebuild",
  require "custom.plugins.harpoon-nvim",
  require "custom.plugins.conform-nvim",

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
