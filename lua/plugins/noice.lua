return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    views = {
      cmdline_popup = {
        position = { row = 1, col = "50%" },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
    },
  },
}
