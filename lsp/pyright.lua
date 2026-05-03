return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
  },

  settings = {
    pyright = {
      disableOrganizeImports = true, -- handled by Ruff
    },
    python = {
      analysis = {
        diagnosticsMode = "openFilesOnly",
        typeCheckingMode = "off",
      },
    },
  },
}
