-- show diagnostics (no formatting)
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters by file type
      lint.linters_by_ft = {

        dockerfile = { "hadolint" },

        -- Lua linting is handled by LSP

        -- `markdownlint` gives a lot of warnings which are not really important or automatically
        -- solved when `prettier` runs via `conform`.
        -- markdown = { "markdownlint" },

        python = { "mypy" },

        -- Rust linting is handled by rust-analyzer LSP (includes clippy)

        terraform = { "tflint" },
        tf = { "tflint" },
        tfvars = { "tflint" },

        yaml = { "yamllint" },
      }

      -- Create an autocommand to run the linter on buffer read, buffer write, or when
      -- leaving insert mode
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          -- Only try to lint when diagnostics are enabled for this buffer.
          if vim.diagnostic.is_enabled({ bufnr = 0 }) then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
