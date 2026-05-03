-- I do not always want to format a markdown file as it can lead to a lot of changes that I do not
-- want to include in the same diff. Therefore, this method allows me to manually run formatting
-- when I want to.
local function format_markdown_with_prettier()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == "" then
    vim.notify("Markdown buffer has no file name", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("prettier") ~= 1 then
    vim.notify("prettier executable not found", vim.log.levels.ERROR)
    return
  end

  vim.cmd.update()

  local result = vim
    .system({
      "prettier",
      filename,
      "--write",
      "--print-width",
      "100",
      "--prose-wrap",
      "always",
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    vim.notify(result.stderr ~= "" and result.stderr or "prettier failed", vim.log.levels.ERROR)
    return
  end

  vim.cmd.checktime()
end

vim.keymap.set("n", "<leader>fm", format_markdown_with_prettier, {
  buffer = true,
  desc = "Format markdown with Prettier",
})

