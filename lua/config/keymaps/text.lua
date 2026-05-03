-- Util methods about text.

-- Insert shortdate
vim.keymap.set("n", "<leader>d1", function()
  vim.api.nvim_put({ os.date("%y%m%d") }, "c", false, true)
end, { desc = "Insert short date" })

-- Insert week number like w23
vim.keymap.set("n", "<leader>d2", function()
  vim.api.nvim_put({ "w" .. os.date("%V") }, "c", false, true)
end, { desc = "Insert week number" })
