### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Starship prompt
eval "$(starship init zsh)"

# Use bat as the default manpager
export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Pager
export PAGER='less'

# start zoxide
eval "$(zoxide init zsh)"

#share commands between terminal instances or not

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"


# I have no idea what this does but it's required by zsh-vi-mode
zinit ice depth=1

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Set this before loading the plugin
ZVM_INIT_MODE=sourcing zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Aliases
if [ -d "$HOME/.aliases" ] ;
  then source ~/.aliases/aliases
fi

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey '^o' clear-screen

# exports
export EDITOR='nvim'
export VISUAL='neovide'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt glob_dots
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"

# PATH
# export C_INCLUDE_PATH="/usr/lib/gcc/arm-none-eabi/13.2.0/include/:$HOME/programming/thirdparties/tiva-c/:$HOME/programming/thirdparties/tiva-c/third_party/FreeRTOS/Source/include/:$HOME/programming/thirdparties/tiva-c/boards/ek-tm4c123gxl/freertos_demo/:"
# export C_INCLUDE_PATH="/usr/lib/gcc/arm-none-eabi/13.2.0/include/:$HOME/programming/thirdparties/tiva-c/"
export CPLUS_INCLUDE_PATH="$HOME/programming/cppDev/imgui/imgui/backends:$HOME/programming/cppDev/imgui-sfml:$HOME/programming/cppDev/imgui/imgui/:$HOME/programming/problem_solving/algo/"
export PATH="$PATH:/usr/bin/docker:/usr/local/arm-cross-compiler/install/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH:/opt/usr/bin/"
export PATH="$PATH:$HOME/.scripts/"
export PATH="$PATH:$HOME/.cache/lm-studio/bin"
export PATH="$PATH:$HOME/.cargo/bin/"
# export PATH="$PATH:/opt/android-sdk/tools/bin"
export ANDROID_HOME="/opt/android-sdk"

# Useful functions

# ex = EXtractor for all kinds of archives
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Interactive cd
fcd() {
  local dir
  dir=$(find ~ -type d | fzf)
  if [[ -n $dir ]]; then
      cd "$dir"
  fi
}

# pnpm
export PNPM_HOME="/home/omar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
