if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ~/.config/fish/config.fish

# Set fish greeting (can be disabled or customized)
set -g fish_greeting

# Enable Vi key bindings
fish_vi_key_bindings

# Make auto-complete work for suggestions that are not in command history
bind tab accept-autosuggestion

# ctlr+R now using PatrickF1/fzf.fish

# Set prompt (can replace with your own or a theme)
# function fish_prompt
#     set_color cyan
#     echo -n (prompt_pwd)
#     set_color normal
#     echo -n ' > '
# end

# Useful aliases (like in Bash/Zsh)
alias ll='eza -alF'
alias la='eza -A'
alias g='git'
alias v='nvim'

abbr pacupg 'sudo pacman -Syu'
abbr pacrem 'sudo pacman -Rs'
abbr yaupg 'sudo yay -Syu'
abbr yarem 'sudo yay -Rs'
abbr src 'source ~/.config/fish/config.fish'
abbr ber 'bundle exec rspec'
abbr ls eza
abbr gpom 'git push origin main'
abbr gfu 'git fetch upstream'
abbr gmum 'git merge upstream/main'
abbr python python3
abbr pip pip3

alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"

# Sets XDG paths
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Set editor
set -gx EDITOR nvim

# Add user bin to path if not already
set -U fish_user_paths $HOME/bin $fish_user_paths

# Automatically source ~/.bash_aliases or ~/.zshrc if you have legacy aliases
if test -f ~/.bash_aliases
    bash -c 'source ~/.bash_aliases; compgen -A function; compgen -A alias' | while read line
        eval $line
    end
end

# Optionally include autojump or zoxide for directory jumping
# zoxide is the modern, fast replacement for autojump
if type -q zoxide
    zoxide init fish | source
end

# Completion tweaks
# set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

# Starship prompt support (if using it)
# if type -q starship
#     starship init fish | source
# end
