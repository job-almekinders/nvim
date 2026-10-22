-- Continue comment and list leaders on a new line, toggled per buffer with <leader>cc.
-- Native 'comments' continues literal leaders. Filetypes add rules (see add_rules) for the leaders
-- it can't express.

-- Filetypes where continuation starts enabled. Everywhere else it starts disabled.
local ENABLED_BY_DEFAULT = { markdown = true }

local M = {}

--- Turn continuation on or off for a buffer.
---@param bufnr integer
---@param enabled boolean
local function set_enabled(bufnr, enabled)
  vim.b[bufnr].continuation = enabled
  local formatoptions = vim.bo[bufnr].formatoptions:gsub("[ro]", "")
  vim.bo[bufnr].formatoptions = enabled and formatoptions .. "ro" or formatoptions
end

--- Return an expr mapping for `key` that ends an empty list item or applies the first matching rule.
---@param key string
---@param rules table
---@return function
local function continue_line(key, rules)
  return function()
    if not vim.b.continuation then
      return key
    end
    local line = vim.api.nvim_get_current_line()
    if key == "<CR>" then
      for _, pattern in ipairs(rules.empty_items) do
        if line:match(pattern) then
          return "<C-u>"
        end
      end
    end
    for _, rule in ipairs(rules.leaders) do
      if line:match(rule.pattern) then
        return rule.keys(key, line:match(rule.pattern))
      end
    end
    return key
  end
end

--- Map <CR>, o and O in the current buffer to follow `rules` while continuation is enabled.
--- `rules.empty_items` are patterns for a list item without text: Enter on one clears the line,
--- which ends the list. `rules.leaders` are `{ pattern, keys }` pairs: on the first pattern that
--- matches the current line, `keys(key, ...captures)` returns the keys to send instead of `key`.
---@param rules table
function M.add_rules(rules)
  local opts = { buffer = true, expr = true }
  vim.keymap.set("i", "<CR>", continue_line("<CR>", rules), opts)
  vim.keymap.set("n", "o", continue_line("o", rules), opts)
  vim.keymap.set("n", "O", continue_line("O", rules), opts)
end

--- Toggle continuation for the current buffer.
function M.toggle()
  local enabled = not vim.b.continuation
  set_enabled(0, enabled)
  vim.notify("Continuation " .. (enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("continuation", {}),
  callback = function(args)
    -- This runs before the filetype's own ftplugin, which may set 'formatoptions', so wait for it.
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        set_enabled(args.buf, ENABLED_BY_DEFAULT[args.match] or false)
      end
    end)
  end,
})

return M
