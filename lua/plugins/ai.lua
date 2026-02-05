return {

  -- Notifications ------------------------------------------------------------
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Noice (message routing, command palette, etc.) ---------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- Markdown rendering for chats --------------------------------------------
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },

  -- Spinner for CodeCompanion ------------------------------------------------
  {
    "franco-ruggieri/codecompanion-spinner.nvim",
    lazy = true,
  },

  ---------------------------------------------------------------------------
  -- CodeCompanion
  ---------------------------------------------------------------------------
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
    keys = {
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion / buffer" },
      { "<leader>ai", "<cmd>CodeCompanionChat<cr>", desc = "Inline edit" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
      { "<leader>aR", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Chat: add selection" },
    },

    config = function()
      local default_model = "stepfun/step-3.5-flash:free"

      local openai = require("codecompanion.adapters.http.openai")
      local available_models = {
        "google/gemini-2.0-flash-001",
        "google/gemini-2.5-pro-preview-03-25",
        "tngtech/deepseek-r1t2-chimera:free",
        "deepseek/deepseek-r1:free",
        "meta-llama/llama-3.3-70b-instruct:free",
        "qwen/qwen3-coder:free",
        "stepfun/step-3.5-flash:free",
      }
      local current_model = default_model

      local function select_model()
        vim.ui.select(available_models, {
          prompt = "Select Model:",
        }, function(choice)
          if choice then
            current_model = choice
            vim.notify("Selected model: " .. current_model)
          end
        end)
      end

      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              position = "left",
            },
          },
        },

        diff = {
          enabled = true,
          inline = {
            layout = "float",
            opts = {
              context_lines = 3,
              dim = 50,
              full_width_removed = true,
              show_keymap_hints = true,
              show_removed = true,
            },
          },
        },

        strategies = {
          chat = {
            adapter = "openrouter",
            roles = {
              user = "User",
              system = function(adapter)
                return "CodeCompanion"
              end,
            },
            tools = {
              groups = {
                plan = {
                  description = "Plan: Give model access to read/search filesystem.",
                  prompt = "Use $tools to inspect files; do not modify.",
                  tools = { "file_search", "grep_search", "read_file", "list_code_usages" },
                  opts = { collapse_tools = true },
                },
                act = {
                  description = "Act: Allow file editing & commands.",
                  prompt = "Use $tools to apply the approved plan with minimal diffs.",
                  tools = { "insert_edit_into_file", "create_file", "cmd_runner" },
                  opts = { collapse_tools = true },
                },
              },
            },
            keymaps = {
              send = {
                modes = {
                  n = "<C-s>",
                  i = "<C-s>",
                },
              },
            },
          },
          inline = {
            adapter = "openrouter",
          },
        },

        adapters = {
          http = {
            openrouter = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "https://openrouter.ai/api",
                  api_key = vim.env.NVIM_OPENROUTER_API_KEY,
                  chat_url = "/v1/chat/completions",
                },
                schema = {
                  model = {
                    default = current_model,
                  },
                },
              })
            end,
          },
        },

        log_level = "DEBUG",

        extensions = {
          spinner = {},
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
          },
        },
      })

      -- Model selector keymap
      vim.keymap.set("n", "<leader>am", select_model, { desc = "Select AI Model" })

      -- Notifications
      local notify = vim.notify
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionStartedInline",
        callback = function()
          notify("Inline edit started", vim.log.levels.INFO, { title = "CodeCompanion" })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionFinishedInline",
        callback = function()
          notify("Inline edit finished", vim.log.levels.INFO, { title = "CodeCompanion" })
        end,
      })
    end,
  },
}
