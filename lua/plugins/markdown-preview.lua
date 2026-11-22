return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<CR>",
      ft = "markdown",
      mode = "n",
      desc = "[m]arkdown toggle [p]review",
    },
  },
  build = function()
    -- Install the prebuilt binary when available to avoid Node/Yarn runtime issues.
    vim.fn["mkdp#util#install_sync"](1)
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
