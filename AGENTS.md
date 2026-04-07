# dotfiles

## Setup

```bash
# Install dotfiles (creates symlinks via rcm)
rcup

# Package management
pnpm install
```

## Release workflow

```bash
pnpm run cs:prepare    # Create changeset
# ... edit .changeset/*.md ...
pnpm run cs:version   # Bump versions (committed automatically)
git push              # Triggers GitHub Actions release workflow
```

Uses [changesets](https://github.com/changesets/changesets) for versioning. Release PRs are created automatically on push to `main`.

## Key dotfiles

| File | Purpose |
|------|---------|
| `zshrc` | Main shell config (oh-my-zsh, vi mode, editor, PATH) |
| `zprofile` | Login shell (brew shellenv, rbenv) |
| `gitconfig` | Git settings, LFS, GitHub SSH rewrite |
| `tmux.conf` | tmux with TPM plugins, powerline, vi bindings |
| `vimrc` | Neovim/Vim config (vim-plug) |
| `config/mcphub/servers.json` | MCP server definitions |

## Architecture quirks

- **ARM vs Intel Macs**: `zshrc` and `tmux.conf` branch on `$(uname -m)` for different paths
- **External script sourcing**: `zshrc` sources `~/dev/env/github.sh`, `~/bin/excel`, `~/bin/bazel.sh` if they exist
- **Vim plugins**: Loaded from `~/.vim/plugins/` (must be symlinked separately)
- **RCM excludes** (from `rcrc`): `*.lock`, `*.lock.yaml`, `*.lock.yml`, `*.omp.json`, `node_modules/`, `package.json`, `README.md`, `CHANGELOG.md`

## Editor defaults

- `EDITOR` and `VISUAL` set to `nvim`
- Vi keybindings in readline (`set -o vi` in zshrc)
- Vim uses 2-space indent (JS/TS/YAML), 4-space (Python)
