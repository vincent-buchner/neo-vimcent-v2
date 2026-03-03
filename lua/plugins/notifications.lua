return {
  "folke/snacks.nvim",
  optional = true,
  opts = {
    notifier = {
      style = "fancy", -- "compact" | "fancy" | "minimal"
      top_down = true,
      timeout = 5000,
    },
  },
  keys = {
    {
      "<leader>fn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Find Notifications (history)",
    },
    {
      "<leader>fN",
      function()
        local history = Snacks.notifier.get_history()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values

        pickers
          .new({}, {
            prompt_title = "Notification History",
            finder = finders.new_table({
              results = history,
              entry_maker = function(entry)
                local msg = entry.msg or ""
                msg = msg:gsub("\n", " ")
                return {
                  value = entry,
                  display = string.format("[%s] %s", entry.level or "info", msg),
                  ordinal = msg,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end,
      desc = "Notification History (telescope)",
    },
  },
}
