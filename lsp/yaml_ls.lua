return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
  root_markers = { ".git" },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    -- formatting disabled by default in yaml-language-server; enable it
    yaml = { format = { enable = true } },
    schemas = {
      -- Azure Pipelines
      ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
        "azure-pipelines.yml",
        "azure-pipelines.yaml",
        "*.azure-pipelines.yml",
        "pipelines/*.yml",
      },
      -- Docker Compose
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
        "docker-compose.yml",
        "docker-compose.yaml",
        "compose.yml",
        "compose.yaml",
      },
      -- GitHub Actions
      ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
      ["https://json.schemastore.org/github-action.json"] = "action.yml",
      -- Kubernetes
      ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json"] = {
        "k8s/*.yaml",
        "manifests/*.yaml",
        "deployment.yaml",
        "service.yaml",
        "pod.yaml",
      },
    },
  },
  on_init = function(client)
    --- https://github.com/neovim/nvim-lspconfig/pull/4016
    --- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
    --- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
    --- autocmd's which check this capability
    client.server_capabilities.documentFormattingProvider = true
  end,
}
