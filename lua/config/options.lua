-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Spead up Neovim
if vim.loader then
  vim.loader.enable()
end
vim.g.do_filetype_lua = 1
vim.opt.shell = "/bin/sh"

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set the terminal title
vim.opt.title = true
vim.opt.titlestring = "%m %t - nvim"

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Show the active vim mode --> lualine should show this as well
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or => 1 capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 28

-- if performing an operation that would fail due to unsaved changes in the buffer
-- (like `:q`), instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Prevent double loading
vim.cmd("syntax off")

-- set tab configuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- set vertical line in files
-- vim.opt.colorcolumn = "88"

-- Auto wrap text when typing
vim.opt.textwidth = 0 -- Disable auto wrapping
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Break lines at word boundaries instead of mid-word

-- folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using nvim-ufo provider needs a large value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- continue with comments or not
-- r – continue comments when pressing Enter in Insert mode
-- o – continue comments when using o or O in Normal mode
-- c – auto-wrap comments and continue them when wrapping
-- vim.opt.formatoptions:remove({ "c", "r", "o" })

-- make sure it does not pre select the first autocomplete suggestion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- add filetypes explicitly to help to attach to lsp
vim.filetype.add({
  extension = {
    sh = "sh",
    bash = "sh",
  },
  filename = {
    [".bashrc"] = "sh",
    [".zshrc"] = "sh",
    [".zprofile"] = "sh",
  },
})

-- let neovim use its own small and fast python venv
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")
