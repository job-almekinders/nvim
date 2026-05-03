return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "ruff.toml",
    ".ruff.toml",
  },
  init_options = {
    settings = {
      logLevel = "debug",
      lineLength = 88,
    },
  },
  single_file_support = true,
}
