return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    open_mapping = [[<C-\\>]],
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      title_pos = "center",
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal mode keymaps
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = function()
        local map = function(lhs, rhs)
          vim.keymap.set("t", lhs, rhs, { silent = true, buffer = 0 })
        end

        map("<esc>", [[<C-\><C-n>]])
        map("<C-h>", [[<C-\><C-n><C-w>h]])
        map("<C-j>", [[<C-\><C-n><C-w>j]])
        map("<C-k>", [[<C-\><C-n><C-w>k]])
        map("<C-l>", [[<C-\><C-n><C-w>l]])
      end,
    })

    -- Helper: close a terminal via picker
    local function close_term_picker(include_hidden)
      local ok, terms = pcall(function()
        return require("toggleterm.terminal").get_all(include_hidden)
      end)
      if not ok or #terms == 0 then
        vim.notify("No toggleterms are open", vim.log.levels.INFO)
        return
      end

      vim.ui.select(terms, {
        prompt = "Select terminal to close:",
        format_item = function(term)
          local name = term._display_name and term:_display_name() or (term.name or ("term " .. term.id))
          return string.format("%d: %s", term.id, name)
        end,
      }, function(term)
        if not term then
          return
        end
        pcall(vim.api.nvim_buf_delete, term.bufnr, { force = true })
      end)
    end

    -- Shortcut function for mapping
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
    end

    -- Core keymaps
    map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", "Terminal: Toggle (float)")
    map("n", "<leader>tn", "<cmd>TermNew direction=float<cr>", "Terminal: New (float)")
    map("n", "<leader>ts", "<cmd>TermSelect<cr>", "Terminal: Select")
    map("n", "<leader>tS", "<cmd>TermSelect!<cr>", "Terminal: Select (include hidden)")
    map("n", "<leader>tr", "<cmd>ToggleTermSetName<cr>", "Terminal: Rename")
    map("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", "Terminal: Toggle All")
    map("n", "<leader>tx", function()
      close_term_picker(false)
    end, "Terminal: Close (picker)")

    -- Quick jump to terminals 1–9
    for i = 1, 9 do
      map(
        "n",
        string.format("<leader>t%d", i),
        string.format("<cmd>%dToggleTerm direction=float<cr>", i),
        string.format("Terminal: Toggle #%d", i)
      )
    end
  end,
}

-- return {
--   {
--     "akinsho/toggleterm.nvim",
--     version = "*",
--     opts = {
--       shade_terminals = true,
--       start_in_insert = true,
--       insert_mappings = true,
--       open_mapping = [[<C-_>]], -- Ctrl-/
--       direction = "float",
--       float_opts = {
--         border = "curved",
--         width = math.floor(vim.o.columns * 0.8),
--         height = math.floor(vim.o.lines * 0.8),
--         title_pos = "center",
--       },
--     },
--   },
-- }
