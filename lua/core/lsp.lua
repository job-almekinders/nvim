-- Enable all the LSPs
vim.lsp.enable({
  "bash_ls",
  "bicep_ls",
  "docker_ls",
  "gopls",
  "lua_ls",
  "pyright",
  "ruff",
  "rust_analyzer",
  "terraform_ls",
  "yaml_ls",
})

-- LSP keymaps and autocommands
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- LSP keymaps
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    -- Go to Definition
    map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "<leader>gdx", function()
      vim.cmd("belowright split")
      vim.lsp.buf.definition()
    end, "Go to definition (split)")
    map("n", "<leader>gdv", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, "Go to definition (vsplit)")
    map("n", "<leader>gdt", function()
      vim.cmd("tab split")
      vim.lsp.buf.definition()
    end, "Go to definition (tab)")

    -- Show hover documentation
    map("n", "<leader>k", vim.lsp.buf.hover, "Show hover documentation")

    -- Go to implementation
    map("n", "<leader>gi", vim.lsp.buf.implementation, "Go to implementation")

    -- Show references (using Snacks picker)
    map("n", "<leader>gr", function()
      require("snacks").picker.lsp_references()
    end, "Show references")

    -- Rename symbol
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

    -- Show code actions (for refactoring, fixing errors, etc.)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Show code actions")

    -- Show line diagnostics in a floating window
    map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
  end,
})

-- Show current active lsp clients
local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    print("No LSP clients attached.")
    return
  end

  local client_names = {}
  for _, buf_client in ipairs(buf_clients) do
    table.insert(client_names, buf_client.name .. " (ID: " .. buf_client.id .. ")")
  end
  print("Attached: " .. table.concat(client_names, ", "))
end

-- Keymap to trigger the check
vim.keymap.set("n", "<leader>lac", get_attached_clients, { desc = "[L]SP [A]ttached [C]lients" })

-- Set diagnostics for all LSPs
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
