return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform" },
  root_markers = {
    ".git",
    ".terraform",
    ".terraform.lock.hcl",
    "terraform.tfvars",
  },
  settings = {
    terraform = {
      languageServer = {
        enable = true,
      },
    },
  },
  single_file_support = true,
}
