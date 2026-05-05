local SIDEKICK_WIDTH_RATIO = 0.2

function sidekick_width()
  return math.max(20, math.floor(vim.o.columns * SIDEKICK_WIDTH_RATIO))
end

return {
  "folke/sidekick.nvim",
  opts = {
    nes = {
      enabled = true,
      diff = {
        inline = "words",
      },
      signs = true,
    },
    cli = {
      watch = false,
      mux = {
        create = "terminal",
        enabled = false,
      },
      win = {
        layout = "left",
        split = {
          width = sidekick_width(),
          height = 0,
        },
        config = function(terminal)
          terminal.opts.split = terminal.opts.split or {}
          terminal.opts.split.width = sidekick_width()
        end,
        keys = {
          hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "Hide Sidekick" },
          stopinsert = { "<esc>", "stopinsert", mode = "t", desc = "Terminal Normal Mode" },
          prompt = { "<c-p>", "prompt", mode = "t", desc = "Navigate left" },
          nav_left = { "<c-h>", "nav_left", mode = "t", expr = true, desc = "Navigate left" },
          nav_right = { "<c-l>", "nav_right", mode = "t", expr = true, desc = "Navigate right" },
          nav_up = { "<c-k>", "nav_up", mode = "t", expr = true, desc = "Navigate up" },
          nav_down = { "<c-j>", "nav_down", mode = "t", expr = true, desc = "Navigate down" },
        },
      },
      tools = {
        claude = {
          cmd = { "claude" },
          native_scroll = true,
          mux = false,
        },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").focus()
      end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>a.",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Sidekick Toggle Claude",
    },
  },
}
