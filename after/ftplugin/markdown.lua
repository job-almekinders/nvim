-- Uncomment to enable auto wrapping
-- vim.opt_local.textwidth = 100

vim.opt_local.colorcolumn = "100"
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

-- n: Recognize numbered lists when formatting text. lua/config/continuation.lua adds r and o.
vim.opt_local.formatoptions:append("n")

-- Tell Neovim to treat '- [ ]', '-', '+', '*' and '>' followed by a space as list leaders.
-- '- [ ]' must come before '-' so the checkbox is continued instead of a plain bullet. Numbered
-- lists are continued by the rules below, which count up.
vim.opt_local.comments = "b:- [ ],b:*,b:-,b:+,n:>"

require("config.continuation").add_rules({
  empty_items = { "^%s*[-*+] ?$", "^%s*[-*+] %[.%] ?$", "^%s*%d+%. ?$", "^%s*> ?$" },
  leaders = {
    -- 'comments' continues "- [x]" as a plain "- ", so start the next item with an empty box.
    {
      pattern = "^%s*[-*+] %[[^ ]%]",
      keys = function(key)
        return key .. "[ ] "
      end,
    },
    -- 'comments' has no numbered leader, so count up here. "O" inserts above, so it reuses the
    -- number.
    {
      pattern = "^%s*(%d+)%. ",
      keys = function(key, number)
        return key .. (key == "O" and number or number + 1) .. ". "
      end,
    },
  },
})
