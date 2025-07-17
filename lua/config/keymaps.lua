-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shift 5x faster
vim.keymap.set("n", "K", "5k", { desc = "Move up 5 lines" })
vim.keymap.set("n", "J", "5j", { desc = "Move down 5 lines" })

-- Leader+Shift+K to show "learn more" message
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })

-- Toggle the terminal on the bottom
vim.keymap.set("n", "<leader>?", function()
  require("toggleterm").toggle(1, 15, nil, "horizontal")
end, { desc = "Toggle bottom terminal" })

vim.keymap.set("n", "<leader>fs", function()
  require("telescope.builtin").live_grep({ cwd = require("lazyvim.util").root() })
end, { desc = "[F]ind [S]tring (project)" })
