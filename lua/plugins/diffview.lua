-- enable git diff views
return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    keys = {
      { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "[G]it diffview [O]pen" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it diffview [C]lose" },
    },
  },
}
