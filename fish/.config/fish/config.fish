# theme
set -g theme_color_scheme terminal-dark

set -gx TERM xterm-256color
set -gx EDITOR nvim

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.local/opt/go/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias fishrc="nvim ~/.config/fish/config.fish"
alias reload="source ~/.config/fish/config.fish"
alias vi="nvim"
alias py="python3"
starship init fish | source
zoxide init fish | source

# ASDF configuration code
if test -z $ASDF_DATA_DIR
	set _asdf_shims "$HOME/.asdf/shims"
else    
	set _asdf_shims "$ASDF_DATA_DIR/shims"
end
# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
	set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

fish_add_path ~/.spicetify

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# opencode
fish_add_path ~/.opencode/bin

# Homebrew (Apple Silicon or Intel, whichever is present)
if test -x /opt/homebrew/bin/brew
	/opt/homebrew/bin/brew shellenv | source
else if test -x /usr/local/bin/brew
	/usr/local/bin/brew shellenv | source
end
