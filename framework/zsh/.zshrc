export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_DIR="$HOME/.config"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-autosuggestions
    zsh-syntax-highlighting
	)

source $ZSH/oh-my-zsh.sh

# Set vim mode
set -o vi

# Aliases
alias ls="exa --icons"
alias la="exa -lah --icons"
alias p1="ping 1.1.1.1"

alias yt="yt-dlp --add-metadata -i"
alias yta="yt -x -f bestaudio/best"

alias yz="yazi"
alias lg="lazygit"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias ta="tmux attach"
alias th="tmux new-session -s 'Home 🏠' -c '$HOME' "
alias tw="tmux new-session -s 'Wiki 📚' -c '$WIKI_HOME'"

alias prn="poetry run"

alias pom="pomodoro"

# Copilot-like autosuggest
bindkey '^y' autosuggest-accept

# mise integration
[[ $(command -v mise) ]] && eval "$(mise activate zsh)"

# fzf zsh integration 
[[ $(command -v fzf) ]] && eval "$(fzf --zsh)"

# direnv
[[ $(command -v direnv) ]] && eval "$(direnv hook zsh)"

# home manager vars
[[ -d $XDG_CONFIG_DIR/home-manager ]] && source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# powerlevel theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

