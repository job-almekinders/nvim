return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  keys = {
    { "<leader>go", "<cmd>Oil<cr>", desc = "Open Oil" },
    {
      "<leader>yp",
      function()
        if vim.bo.filetype ~= "oil" then
          vim.notify("This keymap only works in Oil buffers.", vim.log.levels.WARN)
          return
        end

        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        local path = entry and dir and (dir .. entry.name) or dir
        if not path then
          vim.notify("Could not resolve Oil path.", vim.log.levels.ERROR)
          return
        end

        vim.fn.setreg("+", path)
        vim.notify("Yanked path: " .. path)
      end,
      desc = "[Y]ank current [P]ath (Oil)",
    },
  },
  lazy = false,
}
