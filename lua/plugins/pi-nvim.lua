-- Ships with default keybindings <leader>p in both visual and normal mode.

return {
  "carderne/pi-nvim",
  config = function()
    require("pi-nvim").setup()
  end,
  keys = {
    { "<leader>pi", ":PiPing<CR>", mode = "n", desc = "Ping pi" },
  },
}
