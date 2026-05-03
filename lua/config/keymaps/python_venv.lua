-- Activate Poetry or uv virtualenv on demand.
local function activate_virtualenv(venv_path)
  local venv_bin = venv_path .. "/bin"
  vim.env.VIRTUAL_ENV = venv_path
  if not vim.startswith(vim.env.PATH or "", venv_bin .. ":") then
    vim.env.PATH = string.format("%s:%s", venv_bin, vim.env.PATH or "")
  end
end

local function restart_python_lsp_servers()
  local target_servers = { pyright = true, ruff = true }
  local active_clients = {}
  local active_server_names = {}
  local seen = {}

  for _, client in ipairs(vim.lsp.get_clients()) do
    if target_servers[client.name] then
      table.insert(active_clients, client)
      if not seen[client.name] then
        table.insert(active_server_names, client.name)
        seen[client.name] = true
      end
    end
  end

  if #active_clients > 0 then
    for _, client in ipairs(active_clients) do
      client:stop(true)
    end
  end

  vim.lsp.enable({ "pyright", "ruff" })
  return active_server_names
end

local function notify_venv_activated(label, active_server_names)
  if #active_server_names > 0 then
    vim.notify(
      string.format(
        "%s venv activated; restarted %s",
        label,
        table.concat(active_server_names, ", ")
      ),
      vim.log.levels.INFO
    )
  else
    vim.notify(
      string.format("%s venv activated; open a Python buffer to start pyright/ruff.", label),
      vim.log.levels.INFO
    )
  end
end

vim.keymap.set("n", "<leader>pv", function()
  local cwd = vim.fn.getcwd()
  local lockfile = cwd .. "/poetry.lock"
  local uv_lib = vim.uv

  if not uv_lib.fs_stat(lockfile) then
    vim.notify("No poetry.lock in current directory", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("poetry") ~= 1 then
    vim.notify("poetry executable not found", vim.log.levels.ERROR)
    return
  end

  local poetry_venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
  if vim.v.shell_error ~= 0 or poetry_venv == "" then
    vim.notify("Unable to resolve Poetry environment", vim.log.levels.ERROR)
    return
  end

  activate_virtualenv(poetry_venv)
  local active_server_names = restart_python_lsp_servers()
  notify_venv_activated("Poetry", active_server_names)
end, { desc = "[P]oetry [V]env activate" })

vim.keymap.set("n", "<leader>uv", function()
  local cwd = vim.fn.getcwd()
  local lockfile = cwd .. "/uv.lock"
  local uv_lib = vim.uv

  if not uv_lib.fs_stat(lockfile) then
    vim.notify("No uv.lock in current directory", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("uv") ~= 1 then
    vim.notify("uv executable not found", vim.log.levels.ERROR)
    return
  end

  local uv_venv = cwd .. "/.venv"
  if not uv_lib.fs_stat(uv_venv) then
    vim.notify("No .venv found; run 'uv sync' first", vim.log.levels.WARN)
    return
  end

  activate_virtualenv(uv_venv)
  local active_server_names = restart_python_lsp_servers()
  notify_venv_activated("uv", active_server_names)
end, { desc = "[U]v [V]env activate" })