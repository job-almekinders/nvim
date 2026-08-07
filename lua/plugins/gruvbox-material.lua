-- colortheme

local theme = require("config.theme")

return {
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.o.background = theme.nvim_background()

      if theme.name == "gruvbox" or theme.name == "gruvbox-light" then
        vim.cmd.colorscheme(theme.nvim_colorscheme())
      end
    end,
  },
}
