# dotfiles

Personal configuration for bash, zsh, tmux, and yazi, built around Arch Linux, a suckless-style X setup (dwm/st), and Tokyo Night / Gruvbox colors. A `nvim/` config (LazyVim-based) lives here too and gets symlinked by the installer, but it isn't documented below.

## What's here

| File / dir      | Links to               | Covers |
|------------------|-------------------------|--------|
| `bashrc`         | `~/.bashrc`             | aliases, prompt |
| `bash_profile`   | `~/.bash_profile`       | sources `.bashrc`, starts X |
| `zshrc`          | `~/.zshrc`              | completion, prompt (vcs_info), plugins, SSH agent, aliases |
| `zprofile`       | `~/.zprofile`           | XDG paths, `$EDITOR`/`$TERMINAL`, starts X on tty1 |
| `tmux.conf`      | `~/.tmux.conf`          | prefix `C-Space`, vi mode, vim-aware pane navigation, TPM plugins |
| `yazi/`          | `~/.config/yazi`        | Gruvbox Dark flavor, chafa image preview |
| `nvim/`          | `~/.config/nvim`        | LazyVim config (not covered here) |

## Requirements

This was written for **Arch Linux**: `bashrc`/`zshrc` call `pacman`, `paccache`, and `journalctl` directly in the `clean` alias, and `zshrc` points `DEBUGINFOD_URLS` at `debuginfod.archlinux.org`. It'll mostly work elsewhere, but those bits won't.

Core:
- `bash` and `zsh`
- `git`
- `tmux` (>= 3.2 recommended, for `focus-events`/`terminal-features`)
- [`yazi`](https://yazi-rs.github.io/)
- `neovim` (aliased as `vim`, set as `$EDITOR`)
- A terminal with true color / 256-color support and a Nerd Font, for the prompt colors and yazi icons

For specific features:
- `chafa`: image preview backend yazi is configured to use (`yazi/theme.toml`)
- `fastfetch`: aliased from `neofetch`
- `rust`/`cargo`: `bashrc`, `bash_profile`, and `zshrc` all source `~/.cargo/env`
- `openssh`: `zshrc` starts an `ssh-agent` on login and loads `~/.ssh/id_ed25519` if present
- `zsh-autosuggestions` and `zsh-syntax-highlighting`: `zshrc` sources them from `/usr/share/zsh/plugins/`, the path Arch's packages use
- `st` (suckless terminal): set as `$TERMINAL` in `zprofile`, not required, just the default
- `xdg-user-dirs`: used by the `cuis` alias to find your desktop folder regardless of locale, falls back to a plain directory check if it's missing

A few aliases still point outside this repo, to things that live only on the machine they were written for: `cad` and `shortcuts` call scripts under `~/dev/suckless-btw/scripts/`, and `cuis` expects a Smalltalk (Cuis) image under `linux64/` inside your desktop folder. `cuis` resolves that folder with `xdg-user-dir DESKTOP` when it's available, so it works regardless of locale (`Desktop`, `Escritorio`, etc.); without `xdg-user-dirs` installed it falls back to checking the common casings directly. None of that is required for bash, zsh, tmux, or yazi to work; those aliases just won't do anything until the paths exist.

## Install

The installer hardcodes the source path, so clone this to exactly `~/dotfiles`:

```sh
git clone <this-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks each file into place. If something already exists at the destination and isn't already a symlink, it gets moved to `<name>.bak` first, so re-running it is safe.

### After installing

**tmux plugins**: this config uses [TPM](https://github.com/tmux-plugins/tpm), which isn't vendored here. Install it once, then let tmux pull the plugins:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Start (or reload) tmux, then press `prefix + I` (that's `C-Space` then `I`, given the prefix remap in `tmux.conf`) to fetch `tmux-monokai-pro` and `tmux-yank`.

**yazi flavor**: the Gruvbox Dark flavor is already vendored under `yazi/flavors/`, so no extra step is needed to use it. `yazi/package.toml` lists it as a plugin dependency in case you want to manage it through yazi's own package manager instead (`ya pack -a` to (re)install everything it declares, `ya pack -u` to update).

## Notes

- `bash_profile` calls `startx` unconditionally on source, with no TTY check. `zprofile` guards the same call with `[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]`. If you log in with bash on anything other than tty1, expect X to start anyway.
- `EDITOR` is `nvim` and `TERMINAL` is `st`, set in `zprofile`. Bash sessions don't get these unless something else exports them, since `bash_profile` doesn't set them itself.
