-- Ships with default keybindings <leader>p in both visual and normal mode.

return {
  "carderne/pi-nvim",
  config = function()
    require("pi-nvim").setup()
  end,
  keys = {
    { "<leader>pp", ":PiSend<CR>", mode = "n", desc = "Send prompt to pi" },
    { "<leader>pf", ":PiSendFile<CR>", mode = "n", desc = "Send current file to pi" },
    { "<leader>ps", ":PiSendSelection<CR>", mode = "v", desc = "Send selection to pi" },
    { "<leader>pb", ":PiSendBuffer<CR>", mode = "n", desc = "Send buffer to pi" },
    { "<leader>pi", ":PiPing<CR>", mode = "n", desc = "Ping pi" },
  },
}
