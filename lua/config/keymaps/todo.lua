-- Util methods to keep todo lists in plain markdown files.

-- Insert [running] at the start of the current line
vim.keymap.set("n", "<leader>ir", "0i[running] <Esc>", { desc = "Insert [running] at line start" })

-- Insert [] at the start of the current line and move to insert mode into the brackets
vim.keymap.set("n", "<leader>it", "0i[] <Esc>hi", { desc = "Insert [] at line start" })

-- Remove leading [tag] from the current line (e.g. [some-tag] )
vim.keymap.set("n", "<leader>iT", function()
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line((line:gsub("^%[[^%]]*%]%s*", "")))
end, { desc = "Remove leading [Tag] from line" })

-- Open today's todo file in ~/todos (e.g. monday.md)
vim.keymap.set("n", "<leader>gt", function()
  local weekday = os.date("%A"):lower()
  local todo_path = vim.fn.expand("~/todos/" .. weekday .. ".md")
  vim.cmd.edit(vim.fn.fnameescape(todo_path))
end, { desc = "[G]o to [t]odos" })

local function markdown_heading_level(line)
  local hashes = line:match("^(#+)%s+")
  if not hashes then
    return nil
  end
  return #hashes
end

local function item_block_end(lines, start_idx, max_idx)
  local end_idx = start_idx

  for i = start_idx + 1, max_idx do
    local line = lines[i]
    if line == "" then
      local next_line = lines[i + 1]
      if next_line and next_line:match("^%s+") then
        end_idx = i
      else
        break
      end
    elseif line:match("^%s+") then
      end_idx = i
    else
      break
    end
  end

  return end_idx
end

local function find_markdown_section_index(lines, section_name)
  local section_pattern = "^#+%s*" .. vim.pesc(section_name:lower()) .. "%s*$"
  for i, line in ipairs(lines) do
    if line:lower():match(section_pattern) then
      return i
    end
  end
  return nil
end

-- Get the next todo item from one of the headers below
local function pull_next_focus_from_prioritized_sections()
  local buffer_number = vim.api.nvim_get_current_buf()
  local buffer_lines = vim.api.nvim_buf_get_lines(buffer_number, 0, -1, false)

  if #buffer_lines == 0 then
    vim.notify("Buffer is empty", vim.log.levels.WARN)
    return
  end

  local prioritized_section_names = { "next", "later" }
  local source_section_name
  local source_section_start_idx

  for _, section_name in ipairs(prioritized_section_names) do
    local section_start_idx = find_markdown_section_index(buffer_lines, section_name)
    if section_start_idx then
      source_section_name = section_name
      source_section_start_idx = section_start_idx
      break
    end
  end

  if not source_section_start_idx then
    vim.notify("No # next or # later section found", vim.log.levels.WARN)
    return
  end

  local source_section_level = markdown_heading_level(buffer_lines[source_section_start_idx]) or 1
  local source_section_end_exclusive = #buffer_lines + 1
  for i = source_section_start_idx + 1, #buffer_lines do
    local heading_level = markdown_heading_level(buffer_lines[i])
    if heading_level and heading_level <= source_section_level then
      source_section_end_exclusive = i
      break
    end
  end

  local moved_block_start_idx
  for i = source_section_start_idx + 1, source_section_end_exclusive - 1 do
    if buffer_lines[i]:match("%S") then
      moved_block_start_idx = i
      break
    end
  end

  if not moved_block_start_idx then
    vim.notify("# " .. source_section_name .. " has no actionable content", vim.log.levels.WARN)
    return
  end

  local moved_block_end_idx = moved_block_start_idx
  local moved_block_start_heading_level =
    markdown_heading_level(buffer_lines[moved_block_start_idx])

  if moved_block_start_heading_level then
    for i = moved_block_start_idx + 1, source_section_end_exclusive - 1 do
      local heading_level = markdown_heading_level(buffer_lines[i])
      if heading_level and heading_level <= moved_block_start_heading_level then
        moved_block_end_idx = i - 1
        break
      end
      moved_block_end_idx = i
    end
  else
    moved_block_end_idx =
      item_block_end(buffer_lines, moved_block_start_idx, source_section_end_exclusive - 1)
  end

  local moved_block_lines = {}
  for i = moved_block_start_idx, moved_block_end_idx do
    table.insert(moved_block_lines, buffer_lines[i])
  end

  vim.api.nvim_buf_set_lines(
    buffer_number,
    moved_block_start_idx - 1,
    moved_block_end_idx,
    false,
    {}
  )
  vim.api.nvim_buf_set_lines(
    buffer_number,
    0,
    0,
    false,
    vim.list_extend(moved_block_lines, { "" })
  )
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
end

-- Push the top most todo item into one of the headers below
local function push_top_focus_to_next_header()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  if #lines == 0 then
    vim.notify("Buffer is empty", vim.log.levels.WARN)
    return
  end

  local start_idx
  for i, line in ipairs(lines) do
    if line:match("%S") then
      start_idx = i
      break
    end
  end

  if not start_idx then
    vim.notify("Buffer has no actionable content", vim.log.levels.WARN)
    return
  end

  local end_idx = start_idx
  local start_level = markdown_heading_level(lines[start_idx])

  if start_level then
    for i = start_idx + 1, #lines do
      local level = markdown_heading_level(lines[i])
      if level and level <= start_level then
        end_idx = i - 1
        break
      end
      end_idx = i
    end
  else
    end_idx = item_block_end(lines, start_idx, #lines)
  end

  local moved_lines = {}
  for i = start_idx, end_idx do
    table.insert(moved_lines, lines[i])
  end

  vim.api.nvim_buf_set_lines(bufnr, start_idx - 1, end_idx, false, {})

  local updated_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local next_header_idx
  for i, line in ipairs(updated_lines) do
    if markdown_heading_level(line) then
      next_header_idx = i
      break
    end
  end

  if not next_header_idx then
    vim.notify("No next header found", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(bufnr, next_header_idx, next_header_idx, false, moved_lines)
  vim.api.nvim_win_set_cursor(0, { next_header_idx + 1, 0 })
end

vim.api.nvim_create_user_command(
  "TodoPullNextFocused",
  pull_next_focus_from_prioritized_sections,
  {
    desc = "Move next focus from # next or # later to top",
  }
)

vim.keymap.set("n", "<leader>tn", "<cmd>TodoPullNextFocused<CR>", {
  desc = "[t]odo pull [n]ext focused",
})

vim.api.nvim_create_user_command("TodoPushTopFocused", push_top_focus_to_next_header, {
  desc = "Move top focus under next header",
})

vim.keymap.set("n", "<leader>tN", "<cmd>TodoPushTopFocused<CR>", {
  desc = "[t]odo push top to [N]ext header",
})
