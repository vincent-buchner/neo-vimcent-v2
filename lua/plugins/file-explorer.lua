return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = { enabled = false }, -- ← disable the explorer module
      picker = {
        sources = {
          explorer = { enabled = false },
        },
      },
    },
    keys = {},
  },
  {

    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle right<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        -- Keep the tree at the initial root directory
        bind_to_cwd = false,
        cwd_target = {
          sidebar = "global",
          current = "global",
        },
      },
      window = {
        position = "right",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },
}
