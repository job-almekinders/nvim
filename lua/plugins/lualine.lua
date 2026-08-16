-- horizontal line with info on e.g. open file, filetype, etc.
local theme = require("config.theme")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = theme.lualine_theme(),
        globalstatus = true, -- Force one statusline instead of one per window
        disabled_filetypes = {
          statusline = { "snacks_dashboard", "snacks_explorer" },
          winbar = { "snacks_dashboard", "snacks_explorer" },
        },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●", -- When unsaved
              readonly = " 🔒",
              unnamed = "", -- Replaces "[No Name]" with empty string
              newfile = "[New]",
            },
          },
        },
      },
    },
  },
}
