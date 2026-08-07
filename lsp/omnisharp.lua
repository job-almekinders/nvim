local pid = tostring(vim.uv.os_getpid())

return {
  cmd = { "OmniSharp", "--languageserver", "--hostPID", pid },
  filetypes = { "cs" },
  root_markers = {
    ".git",
    "*.sln",
    "*.csproj",
  },
}
