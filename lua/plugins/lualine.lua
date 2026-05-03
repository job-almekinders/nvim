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
          statusline = { "alpha", "dashboard", "NvimTree", "Outline" },
          winbar = { "alpha", "dashboard", "NvimTree", "Outline" },
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
