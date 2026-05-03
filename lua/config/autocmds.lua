-- Color lines when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- You can pick another highlight group
      timeout = 200, -- Duration in milliseconds
    })
  end,
})
