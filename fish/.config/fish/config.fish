set fish_greeting ""

# theme
set -g theme_color_scheme terminal-dark

set -gx TERM xterm-256color
set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias fishrc="nvim ~/.config/fish/config.fish"
alias reload="source ~/.config/fish/config.fish"
alias ll="exa -l -g"
alias llt="exa -1 --tree"
alias vi="nvim"
alias py="python3"
starship init fish | source
zoxide init fish | source
