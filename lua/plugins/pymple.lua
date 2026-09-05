return {
  {
    "alexpasmantier/pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional (nicer ui)
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    config = function()
      require("pymple").setup()
      vim.keymap.set("n", "<leader>ri", "<cmd>PympleResolveImport<CR>", {
        desc = "[r]esolve [i]mport under cursor",
      })

      -- Keymap to find all objects which have missing imports and adds them.
      local function has_floating_win()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            return true
          end
        end
        return false
      end

      local function resolve_all_imports()
        local bufnr = vim.api.nvim_get_current_buf()
        local tried = {}

        local function get_undefined()
          local diags = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
          local out = {}
          for _, d in ipairs(diags) do
            if d.message:match("is not defined") or d.message:match("[Uu]ndefined name") then
              table.insert(out, d)
            end
          end
          table.sort(out, function(a, b)
            if a.lnum == b.lnum then
              return a.col < b.col
            end
            return a.lnum < b.lnum
          end)
          return out
        end

        local step
        step = function()
          local diags = get_undefined()
          local target
          for _, d in ipairs(diags) do
            if not tried[d.message] then
              target = d
              tried[d.message] = true
              break
            end
          end
          if not target then
            vim.notify(("pymple: done, %d unresolved left"):format(#diags), vim.log.levels.INFO)
            return
          end
          vim.api.nvim_win_set_cursor(0, { target.lnum + 1, target.col })
          vim.cmd("PympleResolveImport")

          -- wait out any candidate-selection popup, then move on
          local function wait(tries)
            tries = tries or 0
            if has_floating_win() and tries < 50 then
              vim.defer_fn(function()
                wait(tries + 1)
              end, 100)
            else
              vim.defer_fn(step, 300)
            end
          end
          wait()
        end

        step()
      end

      vim.keymap.set("n", "<leader>rI", resolve_all_imports, {
        desc = "[r]esolve all unresolved [I]mports",
      })
    end,
  },
}
