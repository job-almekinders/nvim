-- show open buffers
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        always_show_bufferline = true,
      },
      highlights = {
        buffer_selected = { italic = false },
        buffer_visible = { italic = false },
        modified_selected = { italic = false },
        modified_visible = { italic = false },
      },
    },
    keys = function()
      local keys = {
        { "<leader>x", "<cmd>bd<cr>", desc = "Close Buffer" },
        {
          "<leader>bd",
          "<cmd>BufferLineCloseOthers<cr>",
          desc = "Close all buffers except current",
        },
        { "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
        { "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
        { "<leader>bml", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
        { "<leader>bmr", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      }

      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("bufferline").go_to_buffer(i, true)
          end,
          desc = "Go to Buffer " .. i,
        })
      end

      return keys
    end,
  },
}
