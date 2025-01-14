if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

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
alias mamba="micromamba"

alias rm="rm -i"
alias cp="cp -i"
alias bat="bat --theme base16"
alias mv="mv -i"

alias ta="tmux attach"
alias th="tmux new-session -s 'Home 🏠' -c '$HOME' "
alias tw="tmux new-session -s 'Wiki 📚' -c '$WIKI_HOME'"

alias prn="poetry run"

alias pom="pomodoro"

# Copilot like autosuggest
bindkey '^y' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

