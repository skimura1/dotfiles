# .dotfiles
## What I use:
- Tmux
- Fish
- Ghostty
- Yazi
- Startship

## Setting up on a new machine

Each top-level folder is a [GNU Stow](https://www.gnu.org/software/stow/) package
mirroring its target path under `~`. From the repo root:

```sh
brew install stow
stow fish tmux ghostty yazi   # symlinks each into ~/.config/<tool>
```

Run `stow -R <package>` to re-link after moving files around, `stow -D <package>` to
unlink one.

### Fish specifics

1. Install the tools config.fish expects: `brew install starship zoxide yazi neovim asdf`.
2. After stowing, bootstrap [Fisher](https://github.com/jorgebucaran/fisher) and restore plugins:
   ```fish
   curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
   fisher install jorgebucaran/fisher
   fisher update   # reinstalls everything listed in fish_plugins
   ```
3. `fish_variables` is intentionally untracked (it holds machine-local universal-variable
   state) — nothing to restore there.
