-- auto insert closing brackets, etc.
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local autopairs_rule = require("nvim-autopairs.rule")

      autopairs.setup({
        disable_filetype = { "vim" },
      })

      -- Ensure Markdown link text starts as [] when typing [
      autopairs.add_rule(autopairs_rule("[", "]", { "markdown" }))
    end,
  },
}
