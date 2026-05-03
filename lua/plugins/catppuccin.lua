-- colorscheme

-- return {}

local theme = require("config.theme")

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    if theme.name == "catppuccin" then
      vim.cmd.colorscheme(theme.nvim_colorscheme())
    end
  end,
}
