set fish_greeting ""

# theme
set -g theme_color_scheme terminal-dark

set -gx TERM xterm-256color
set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
# set -gx PATH ~/miniconda3/bin $PATH  # commented out by conda initialize

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias fishrc="nvim ~/.config/fish/config.fish"
alias reload="source ~/.config/fish/config.fish"
alias ll="exa -l -g"
alias llt="exa -1 --tree"
alias vi="nvim"
alias py="python3"
alias todo="nvim ~/Documents/notes/todo.md"
starship init fish | source
zoxide init fish | source

if status is-interactive
and not set -q TMUX
    exec tmux
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/skyler/miniconda3/bin/conda
    eval /home/skyler/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/skyler/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/skyler/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/skyler/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<
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

fish_add_path /Users/skyler/.spicetify
