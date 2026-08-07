# nvim

My personal Neovim configuration. Feel free to use it as inspiration.

Note that this is a highly pragmatic repo and that things may not have been setup in the best way.
Happy to get some feedback :)

## Requirements

- [Neovim](https://neovim.io/) (see `.nvim-version` for the version I run)
- A [Nerd Font](https://www.nerdfonts.com/) installed and set in your terminal
- [fd](https://github.com/sharkdp/fd) — for the file picker/explorer (snacks.nvim)

Note: The `scripts/install_deps.sh` script uses brew to install all the outside-of-Neovim
requirements. I prefer to do all the installs globally instead of relying on a tool like `mason`.

## Setup

Clone into your Neovim config directory:

```bash
git clone https://github.com/job-almekinders/nvim ~/.config/nvim
```

Open Neovim and plugins will install automatically via
[lazy.nvim](https://github.com/folke/lazy.nvim).

## Python

Give Neovim its own small Python venv so it doesn't interfere with project environments:

```bash
python3 -m venv ~/.venvs/nvim
~/.venvs/nvim/bin/pip install -U pip pynvim
```

The config already points to `~/.venvs/nvim/bin/python` via `vim.g.python3_host_prog`.

## ty

`ty` provides both type checking and LSP support. Run it with:

```bash
ty check
```

## Rust

`rustfmt` should be installed via `rustup component add rustfmt`.
