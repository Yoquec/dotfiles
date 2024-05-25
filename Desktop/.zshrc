# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export PATH=$HOME/.local/bin:$PATH:$HOME/go/bin
fi

export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	)

source $ZSH/oh-my-zsh.sh

# vim mode
set -o vi

# aliases
alias ls="exa --icons"
alias la="exa -lah --icons"
alias p1="ping 1.1.1.1"
alias ta="tmux attach"

alias yt="yt-dlp --add-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias gtw="git worktree"

alias vi="nvim"
alias lf="yazi"
alias yz="yazi"
alias mamba="micromamba"

alias rm="rm -i"
alias cp="cp -i"
alias bat="bat --theme base16"
alias mv="mv -i"

alias ac="source /store/yoquec/miniconda3/bin/activate"
alias th="tmux new -s 'Home 🏠'"
alias tw="tmux new -s 'Wiki 📚' -c '$WIKI_HOME'"

alias prn="poetry run"

bindkey '^y' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# activate mise
eval "$(mise activate zsh)"

# Activate new powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
