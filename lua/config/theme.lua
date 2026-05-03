-- This helps with easier changing of my theme.

local M = {}

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function read_theme_name()
  local path = vim.fn.expand("~/.dotfiles/theme/current")
  local file = io.open(path, "r")

  if not file then
    return "catppuccin"
  end

  local content = file:read("*l") or ""
  file:close()

  local name = trim(content)
  if name == "gruvbox" then
    return "gruvbox"
  end

  return "catppuccin"
end

M.name = read_theme_name()

function M.nvim_colorscheme()
  if M.name == "gruvbox" then
    return "gruvbox-material"
  end

  return "catppuccin-macchiato"
end

function M.lualine_theme()
  if M.name == "gruvbox" then
    return "gruvbox-material"
  end

  return "catppuccin-macchiato"
end

return M
