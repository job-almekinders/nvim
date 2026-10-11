-- Uncomment to enable auto wrapping
-- vim.opt_local.textwidth = 100

vim.opt.colorcolumn = "100"
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- I do not always want to format a markdown file as it can lead to a lot of changes that I do not
-- want to include in the same diff. Therefore, the methods here allow me to manually run formatting
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- r: Automatically insert comment leader (bullet/number) after hitting <Enter>
    -- o: Automatically insert comment leader after hitting 'o' or 'O' in Normal mode
    -- n: Recognize numbered lists when formatting text
    vim.opt_local.formatoptions:append("ron")

    -- Tell Neovim to treat '1.', '-', '+', and '*' followed by a space as list leaders
    vim.opt_local.comments = "b:*,b:-,b:+,n:>,b:1."
  end,
})
