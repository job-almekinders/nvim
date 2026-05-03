return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    dependencies = { "folke/twilight.nvim" },
    opts = {
      plugins = {
        gitsigns = { enabled = true },
      },
    },
    keys = {
      {
        "<leader>tz",
        function()
          require("zen-mode").toggle()
        end,
        desc = "[t]oggle [z]en mode",
      },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {
      dimming = {
        alpha = 0.50,
      },
      context = 5, -- amount of lines they try to show around the cursor
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("twilight").toggle()
        end,
        desc = "[t]oggle [t]wilight (dimming)",
      },
    },
  },
}
