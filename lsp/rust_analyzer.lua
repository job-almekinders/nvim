return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = {
    ".git",
    "Cargo.toml",
    "Cargo.lock",
  },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
      },
    },
  },
}
