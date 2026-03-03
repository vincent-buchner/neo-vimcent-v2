return {
  {
    "preservim/vimux",
    config = function()
      -- Optional config
      vim.g.VimuxHeight = "10" -- tmux pane height %
      vim.g.VimuxOrientation = "v" -- "v" vertical (below), "h" horizontal (right)
      vim.g.VimuxUseNearest = 0
      vim.keymap.set("n", "<leader>vr", ":VimuxRunLastCommand<CR>")
      vim.keymap.set("n", "<leader>vp", ":VimuxPromptCommand<CR>")
      vim.keymap.set("n", "<leader>vq", ":VimuxCloseRunner<CR>")
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
