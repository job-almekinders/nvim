-- Requirement: Have `dotnet` installed (brew installable)
return {
  cmd = { "bicep-lsp" },
  filetypes = { "bicep", "bicep-params" },
  root_markers = { ".git" },
  init_options = {},
}
