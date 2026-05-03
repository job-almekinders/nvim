-- add additional git commands and show git info like number of edited lines, etc.
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        watch_gitdir = {
          follow_files = true,
        },
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next [c]hange" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous [c]hange" })

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[h]unk [s]tage" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[h]unk [r]eset" })

          map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "[h]unk [s]tage" })

          map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "[h]unk [r]eset" })

          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[h]unk [S]tage buffer" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[h]unk [R]eset buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[h]unk [p]review" })
          map(
            "n",
            "<leader>hi",
            gitsigns.preview_hunk_inline,
            { desc = "[h]unk preview [i]nline" }
          )

          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "[h]unk [b]lame line" })

          map("n", "<leader>hd", gitsigns.diffthis, { desc = "[h]unk [d]iff this" })

          map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
          end, { desc = "[h]unk [D]iff this ~" })

          map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
          end, { desc = "[h]unk [Q]uickfix list (all)" })
          map("n", "<leader>hq", gitsigns.setqflist, { desc = "[h]unk [q]uickfix list" })

          -- Toggles
          map(
            "n",
            "<leader>tb",
            gitsigns.toggle_current_line_blame,
            { desc = "[t]oggle [b]lame line" }
          )
          map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[t]oggle [w]ord diff" })

          -- Text object
          map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select [i]nner [h]unk" })
        end,
      })

      -- Refresh gitsigns when nvim regains focus (e.g., after git operations in another tmux tab)
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          require("gitsigns").refresh({ all = true })
        end,
      })

      -- Refresh after closing LazyGit terminal inside Neovim
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = { "term://*lazygit*", "lazygit" }, -- covers plugin terminal and filetype
        callback = function()
          require("gitsigns").refresh({ all = true })
        end,
      })

      -- Some UIs name the buffer 'lazygit' (BufLeave hook helps as a fallback)
      vim.api.nvim_create_autocmd("BufLeave", {
        pattern = "lazygit",
        callback = function()
          require("gitsigns").refresh({ all = true })
        end,
      })
    end,
  },
}
