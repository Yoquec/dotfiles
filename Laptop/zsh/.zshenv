export PAGER="bat"
export EDITOR='nvim'
export BAT_THEME="gruvbox-dark"
export WIKI_HOME="$HOME/Nextcloud/Notes/"
export XDG_CONFIG_HOME="$HOME/.config"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"
[ -s "/home/yoquec/.bun/_bun" ] && source "/home/yoquec/.bun/_bun" # bun completions

# golang
export PATH="$PATH:$HOME/go/bin"

# mise
eval "$(mise activate zsh)"

# mamba
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/store/yoquec/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/store/yoquec/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/store/yoquec/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
