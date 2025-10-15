-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shift 5x faster
vim.keymap.set("n", "K", "5k", { desc = "Move up 5 lines" })
vim.keymap.set("n", "J", "5j", { desc = "Move down 5 lines" })

-- Leader+Shift+K to show "learn more" message
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })

-- Toggle the terminal on the bottom
-- vim.keymap.set("n", "<leader>?", function()
--   require("toggleterm").toggle(1, 15, nil, "horizontal")
-- end, { desc = "Toggle bottom terminal" })
--

-- Unmap LazyVim's default Ctrl+/ keybind
vim.keymap.del("n", "<C-/>")
vim.keymap.del("t", "<C-/>")

for _, key in ipairs({ "<C-_>", "<C-/>" }) do
  vim.keymap.set({ "n", "t" }, key, "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
end

-- Toggle floating terminal with Ctrl+/
-- vim.keymap.set("n", "<C-_>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
-- vim.keymap.set("t", "<C-_>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })

-- local map = vim.keymap.set
-- local opts = { noremap = true, silent = true, desc = "Toggle floating terminal" }
--
-- map({ "n", "t" }, "<C-_>", function()
--   -- Use a dedicated ID (e.g., 99) so it never collides with the horizontal one
--   local Terminal = require("toggleterm.terminal").Terminal
--   local float_term = Terminal:new({ id = 99, direction = "float" })
--   float_term:toggle()
-- end, opts)

-- vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle floating terminal" })
--
-- -- Toggle a floating terminal
-- vim.keymap.set("n", "<C-_>", function()
--   require("toggleterm").toggle(1, nil, nil, "float")
-- end, { desc = "Toggle floating terminal" })
--
-- vim.keymap.set("t", "<C-_>", function()
--   require("toggleterm").toggle(1, nil, nil, "float")
-- end, { desc = "Toggle floating terminal" })
--
-- vim.keymap.set({ "n", "t" }, "<C-\\>", function()
--   require("toggleterm").toggle(1, nil, nil, "float")
-- end, { desc = "Toggle floating terminal" })

-- (Optional) Toggle a horizontal terminal at the bottom
-- Uncomment if you prefer horizontal layout sometimes:
-- map("n", "<leader>th", function()
--   require("toggleterm").toggle(1, 15, nil, "horizontal")
-- end, { desc = "Toggle bottom terminal" })

-- Easy escape from terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Escape floating terminal" })

-- Terminal window navigation (when in terminal mode)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], {})
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], {})
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], {})
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], {})

vim.keymap.set("n", "<leader>fs", function()
  require("telescope.builtin").live_grep({ cwd = require("lazyvim.util").root() })
end, { desc = "[F]ind [S]tring (project)" })

-- vim.keymap.set({ "n", "t" }, "<C-_>", function()
--   require("toggleterm").toggle(1, nil, nil, "float")
-- end, { noremap = true, silent = true })

-- vim.keymap.set("n", "<C-_>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
-- vim.keymap.set("t", "<C-_>", [[<C-\><C-n><cmd>ToggleTerm<CR>]], { noremap = true, silent = true })
