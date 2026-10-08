-- format on save
return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },

        go = { "goimports" },

        -- TODO: Bicep should be handled by LSP (needs to be validated).
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
          -- Ensure it uses the ruff binary (arguments)
          lsp_format = "first",
        },
        rust = { "rustfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        -- Terraform is handled by LSP
        yaml = { "prettier" },
      },
      format_on_save = function(bufnr)
        -- Skip markdown in directories listed in `lua/config/local.lua`; format manually with
        -- <leader>fm instead.
        if vim.bo[bufnr].filetype == "markdown" then
          local ok, local_config = pcall(require, "config.local")
          local skip_dirs = ok and local_config.markdown_no_format_on_save or {}
          local path = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
          for _, dir in ipairs(skip_dirs) do
            if vim.startswith(path, vim.fs.normalize(dir) .. "/") then
              return
            end
          end
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      notify_on_error = true,
    })
  end,
}
