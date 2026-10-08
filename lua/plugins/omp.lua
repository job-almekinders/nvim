-- send prompts to the omp agent running in the current directory
return {
  "l3aro/omp.nvim",
  version = "*",
  cmd = { "OmpAsk", "OmpNvimInstallExtension" },
  init = function()
    -- keymaps are defined below so lazy.nvim can load the plugin on first use
    vim.g.omp_nvim_no_keymaps = true
  end,
  keys = {
    {
      -- omp in a right split; cwd matches nvim so the bridge connects to it
      "<leader>ot",
      function()
        require("snacks").terminal.toggle("omp", { win = { position = "right", width = 0.4 } })
      end,
      desc = "omp: toggle terminal",
    },
  },
}
