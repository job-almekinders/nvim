-- Only used for Dockerfile, yamlls handles docker-compose
return {
  cmd = { "docker-language-server", "start", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = {
    "Dockerfile",
  },
}
