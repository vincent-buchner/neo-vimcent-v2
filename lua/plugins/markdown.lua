return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    config = function()
      -- Keep preview open when switching buffers
      vim.g.mkdp_auto_close = 0
    end,
  },

  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()

      -- Continue bullet/numbered list on Enter
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { buffer = true })
    end,
  },
}
