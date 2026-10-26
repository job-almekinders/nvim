-- Yank the file path relative to the git root, plus the line (or line range in visual mode).
vim.keymap.set({ "n", "v" }, "<leader>ypl", function()
  local file = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local path = vim.fs.relpath(root, file) or file
  local first, last = vim.fn.line("v"), vim.fn.line(".")
  if first > last then
    first, last = last, first
  end
  local suffix = first == last and tostring(first) or (first .. "-" .. last)
  vim.fn.setreg("+", path .. ":" .. suffix)
  vim.notify("Yanked: " .. path .. ":" .. suffix)
end, { desc = "[y]ank [p]ath + [l]ine" })
