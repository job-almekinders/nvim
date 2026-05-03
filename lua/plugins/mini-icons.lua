-- icons
return {
  "nvim-mini/mini.nvim",
  version = "*",
  config = function()
    require("mini.icons").setup()
    -- Mock nvim-web-devicons so other plugins can use mini.icons
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
