
local copilot_cmp = require("copilot_cmp")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

copilot_cmp.setup {
  opts = {},

  sources = {
    -- Copilot Source
    { name = "copilot", group_index = 2, priority = 100 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  },

  mapping = {
    ["<CR>"] = copilot_cmp.mapping.confirm({ select = true }),
    ["<C-y>"] = copilot_cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = copilot_cmp.mapping.abort(),
    ["<Tab>"] = vim.schedule_wrap(function (fallback)
      if vim.fn.pumvisible() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
      elseif has_words_before() then
      copilot_cmp.mapping.confirm({ select = true })()
      else
      fallback()
      end
    end),
    ["<S-Tab>"] = vim.schedule_wrap(function (fallback)
      if vim.fn.pumvisible() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
      else
      fallback()
      end
    end),
    ["<C-Space>"] = copilot_cmp.mapping.complete(),
  }
}
