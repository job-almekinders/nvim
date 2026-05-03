-- Yank all open buffers AND the directory tree into clipboard
vim.api.nvim_create_user_command("YankOpenBuffers", function()
  local result = {}

  -- Add directory tree for context and keep output manageable.
  table.insert(result, "# Project Structure")
  local tree = vim.fn.system("tree -I 'node_modules|.git|.venv' --gitignore --dirsfirst")
  table.insert(result, "```")
  table.insert(result, tree)
  table.insert(result, "```")
  table.insert(result, "")

  -- Add buffer contents for loaded file-backed buffers.
  table.insert(result, "# Open Buffers")
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        local relpath = vim.fn.fnamemodify(name, ":.")
        table.insert(result, "## File: " .. relpath)
        table.insert(result, "```" .. vim.bo[buf].filetype)

        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for _, line in ipairs(lines) do
          table.insert(result, line)
        end

        table.insert(result, "```")
        table.insert(result, "")
      end
    end
  end

  local text = table.concat(result, "\n")
  vim.fn.setreg("+", text)
  print("Project tree and open buffers yanked to clipboard.")
end, { desc = "Yank project tree and all open buffers" })

vim.keymap.set(
  "n",
  "<leader>yob",
  "<cmd>YankOpenBuffers<CR>",
  { desc = "[Y]ank [O]pen [B]uffers and [T]ree to clipboard" }
)