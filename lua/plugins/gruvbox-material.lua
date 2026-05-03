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

      if theme.name == "gruvbox" then
        vim.cmd.colorscheme(theme.nvim_colorscheme())
      end
    end,
  },
}
