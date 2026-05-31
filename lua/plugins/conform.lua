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
        -- Terraform is handled by LSP
        yaml = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      notify_on_error = true,
    })
  end,
}
