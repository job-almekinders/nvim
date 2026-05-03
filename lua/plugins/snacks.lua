-- collection of other plugins
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          -- focus = "input", -- To put the focus on the search bar when opened.
          auto_close = true, -- This is required to close the explorer when opening a file.
          hidden = true,
          ignored = false,
        },
        files = {
          hidden = true,
          ignored = false,
        },
        grep = {
          hidden = true,
          ignored = false,
        },
      },
    },
    notifier = {
      enabled = true,
      width = { min = 40, max = 0.7 },
    },
    styles = {
      notification = {
        wo = {
          wrap = true,
          linebreak = true,
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("snacks").explorer()
      end,
      desc = "Toggle File Explorer",
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files({ hidden = true, ignored = false })
      end,
      desc = "Find Files (incl. Hidden)",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.grep({ hidden = true, ignored = false })
      end,
      desc = "Grep for Text (incl. Hidden)",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Find Help",
    },
    {
      "<leader>fk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Find Keymaps",
    },
  },
}
