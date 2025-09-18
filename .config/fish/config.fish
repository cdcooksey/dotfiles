if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ~/.config/fish/config.fish

# Set fish greeting (can be disabled or customized)
set -g fish_greeting

# Enable Vi key bindings
fish_vi_key_bindings

# Use Ctrl+R for interactive history search like in Bash/Zsh
# Fish by default binds Ctrl+R to history search; we just ensure it here
bind \cr history-search-backward

# Better history substring search (like Zsh)
# Use FZF if installed for fuzzy history (optional, see below)
# Uncomment if you want fzf-based history
# if type -q fzf
#     bind \cr 'fzf-history-widget'
# end

# Set prompt (can replace with your own or a theme)
# function fish_prompt
#     set_color cyan
#     echo -n (prompt_pwd)
#     set_color normal
#     echo -n ' > '
# end

# Useful aliases (like in Bash/Zsh)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias g='git'
alias v='nvim' # assuming you're a Vim user

abbr pacupg 'sudo pacman -Syu'
abbr pacrem 'sudo pacman -Rs'
abbr yaupg 'sudo yay -Syu'
abbr yarem 'sudo yay -Rs'
abbr src 'source ~/.config/fish/config.fish'
abbr ber 'bundle exec rspec'

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
set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

# Starship prompt support (if using it)
# if type -q starship
#     starship init fish | source
# end
function fzf-history-widget
    set -l token (commandline --current-token)
    set -l command (
        history |
        fzf --height 40% --reverse --tiebreak=index --no-sort --query "$token"
    )
    if test -n "$command"
        commandline --replace -- "$command"
    end
end

bind -M insert \cr fzf-history-widget
