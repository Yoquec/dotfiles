if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export PATH=$HOME/.local/bin:$PATH:$HOME/go/bin
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
alias lg=lazygit

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

# activate mise
eval "$(mise activate zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

