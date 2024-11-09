# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export WIKI_HOME="$HOME/Nextcloud/Notes/"
export PAGER='bat --theme base16'
export GOPATH="$HOME/go"
export PYTHONSTARTUP="$HOME/.config/python/pythonreplrc"
export PTPYTHON_CONFIG_HOME="$HOME/.config/ptpython/"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export BAT_THEME='gruvbox-dark'
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/store/yoquec/micromamba";

# activate ocaml env
[[ ! -r /home/yoquec/.opam/opam-init/init.zsh ]] || source /home/yoquec/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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
