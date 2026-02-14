-- Claude Code integration for Neovim via claudecode.nvim
-- All keybindings are under the <leader>a prefix ("AI")
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" }, -- Uses snacks.nvim for the terminal UI
  config = true,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" }, -- Prefix key group label

    -- Session management
    { "<leader>al", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" }, -- Open/close the Claude terminal
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" }, -- Focus an already open Claude terminal
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" }, -- Resume a previous conversation
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" }, -- Continue the last conversation
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" }, -- Pick which Claude model to use
    {
      "<leader>aR",
      function()
        vim.cmd("ClaudeCodeClose")
        vim.cmd("ClaudeCode --resume")
      end,
      desc = "Restart Claude (resume)",
    },

    -- Sending context to Claude
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" }, -- Send the current buffer as context
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" }, -- Send visual selection to Claude
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" }, -- Only active in file explorer buffers
    },

    -- Diff management (for reviewing Claude's proposed changes)
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
