return {
  -- TypeScript 7 (native) has a built-in LSP and no tsserver.js for typescript-language-server.
  cmd = { "tsc", "--lsp", "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
  single_file_support = true,
}
