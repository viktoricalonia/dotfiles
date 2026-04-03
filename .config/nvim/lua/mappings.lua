require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

require "core.utils".load_mappings("general")
require "core.utils".load_mappings("gitsigns")
require "core.utils".load_mappings("lspconfig")
require "core.utils".load_mappings("dap")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
