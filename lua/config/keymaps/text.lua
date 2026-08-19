-- Util methods about text.

-- Insert shortdate
vim.keymap.set("n", "<leader>d1", function()
  vim.api.nvim_put({ os.date("%y%m%d") }, "c", false, true)
end, { desc = "Insert short date" })

-- Insert week number like w23
vim.keymap.set("n", "<leader>d2", function()
  vim.api.nvim_put({ "w" .. os.date("%V") }, "c", false, true)
end, { desc = "Insert week number" })

-- Toggle comment auto-continuation
vim.keymap.set("n", "<leader>cc", function()
  vim.opt_local.formatoptions:append("cro")
  vim.notify("Comment continuation enabled", vim.log.levels.INFO)
end, { desc = "Continue comments" })

vim.keymap.set("n", "<leader>cC", function()
  vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  vim.notify("Comment continuation disabled", vim.log.levels.INFO)
end, { desc = "Continue comments (remove)" })
