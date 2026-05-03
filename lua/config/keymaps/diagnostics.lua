-- Toggle diagnostics for the current buffer
vim.keymap.set("n", "<leader>td", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })

  vim.diagnostic.enable(not enabled, { bufnr = bufnr })
  print(enabled and "Diagnostics disabled" or "Diagnostics enabled")
end, { desc = "[t]oggle [d]iagnostics for current buffer" })

