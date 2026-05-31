return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = {
    ".git",
    "go.mod",
    "go.work",
  },
  settings = {
    gopls = {
      analyses = {
        staticcheck = true,
      },
      gofumpt = false,
      usePlaceholders = true,
    },
  },
}
