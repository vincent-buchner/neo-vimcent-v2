return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      open_mapping = [[c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        title_pos = "center",
      },
    },
  },
}
