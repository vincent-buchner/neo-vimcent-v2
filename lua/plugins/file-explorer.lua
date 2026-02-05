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
    keys = {
      -- Explicitly disable the explorer keybinding
      { "<leader>e", false },
    },
  },
  {

    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
      { "<leader>e", "<cmd>Neotree toggle right<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false, -- ← this is the key line: false = show dotfiles
          hide_gitignored = false, -- keep ignoring .gitignore files (recommended)
          hide_by_name = {},
          never_show = {},
        },
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
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
