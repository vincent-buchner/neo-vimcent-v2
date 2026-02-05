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
      -- Chat / Inline / Actions
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion / buffer" },
      { "<leader>ai", "<cmd>CodeCompanionChat<cr>", desc = "Inline edit" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },

      -- Chat presets
      { "<leader>aR", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Chat: add selection" },
      { "<leader>a1", "<cmd>CodeCompanionChat llama3_3<cr>", desc = "Chat: Llama 3.3" },
      { "<leader>a2", "<cmd>CodeCompanionChat gemini_2_5_flash<cr>", desc = "Chat: Gemini 2.5 Flash" },
      { "<leader>a3", "<cmd>CodeCompanionChat deepseek_r1_t2<cr>", desc = "Chat: Deepseek R1 T2" },
      { "<leader>a4", "<cmd>CodeCompanionChat qwen_coder_3<cr>", desc = "Chat: Qwen Coder 3" },
      { "<leader>a5", "<cmd>CodeCompanionChat gemini_3_27b<cr>", desc = "Chat: Gemini 3 27B" },
    },

    opts = {
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

      -- Adapters -------------------------------------------------------------
      adapters = {
        http = {
          qwen_coder_3 = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "QWEN CODER 3",
              env = {
                url = "https://openrouter.ai/api",
                api_key = vim.env.NVIM_OPENROUTER_API_KEY,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = { default = "qwen/qwen3-coder:free" },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,

          deepseek_r1_t2 = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "DEEP SEEK R1 T2",
              env = {
                url = "https://openrouter.ai/api",
                api_key = vim.env.NVIM_OPENROUTER_API_KEY,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = { default = "tngtech/deepseek-r1t2-chimera:free" },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,

          llama3_3 = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "LLAMA 3.3",
              env = {
                url = "https://openrouter.ai/api",
                api_key = vim.env.NVIM_OPENROUTER_API_KEY,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = { default = "meta-llama/llama-3.3-70b-instruct:free" },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,

          gemini_2_5_flash = function()
            return require("codecompanion.adapters").extend("gemini", {
              formatted_name = "GEMINI 2.5 FLASH",
              env = {
                api_key = vim.env.NVIM_GEMINI_API_KEY,
              },
              schema = {
                model = { default = "gemini-2.5-flash" },
              },
            })
          end,

          gemini_3_27b = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "GEMINI 3 27B",
              env = {
                url = "https://openrouter.ai/api",
                api_key = vim.env.NVIM_OPENROUTER_API_KEY,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = { default = "google/gemma-3-27b-it:free" },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,
        },

        -- Strategies -----------------------------------------------------------
        strategies = {
          chat = {
            adapter = "gemini_2_5_flash",
            roles = {
              user = "User",
              system = function(adapter)
                return "CodeCompanion (" .. adapter.formatted_name .. ")"
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
            adapter = "gemini_2_5_flash",
          },
        },

        log_level = "DEBUG",

        extensions = {
          spinner = {},
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
          },
        },
      },

      config = function(_, opts)
        require("codecompanion").setup(opts)

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
  },
}
