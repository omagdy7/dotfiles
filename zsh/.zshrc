export CPLUS_INCLUDE_PATH="$HOME/programming/cppDev/imgui/imgui/backends:$HOME/programming/cppDev/imgui-sfml:$HOME/programming/cppDev/imgui/imgui/:$HOME/programming/problem_solving/algo/"
# export C_INCLUDE_PATH="/usr/lib/gcc/arm-none-eabi/13.2.0/include/:$HOME/programming/thirdparties/tiva-c/:$HOME/programming/thirdparties/tiva-c/third_party/FreeRTOS/Source/include/:$HOME/programming/thirdparties/tiva-c/boards/ek-tm4c123gxl/freertos_demo/:"
export C_INCLUDE_PATH="/usr/lib/gcc/arm-none-eabi/13.2.0/include/:$HOME/programming/thirdparties/tiva-c/"
export ZSH="/home/$USER/.oh-my-zsh"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$PATH:/usr/bin/docker:/usr/local/arm-cross-compiler/install/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin:/home/omar/Android/Sdk"
export PATH=$PATH:$ANDROID_HOME/emulator/
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH:/opt/usr/bin/"


# Starship prompt
eval "$(starship init zsh)"


# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Use bat as the default manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="bat -l man"
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="most"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(copyfile copypath web-search zsh-autosuggestions vi-mode git z colorize zsh-syntax-highlighting)

# (cat ~/.cache/wal/sequences &)

source $ZSH/oh-my-zsh.sh


####   ARCOLINUX SETTINGS   ####
export PAGER='less'


setopt GLOB_DOTS
#share commands between terminal instances or not
setopt SHARE_HISTORY

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
export EDITOR='nvim'
export VISUAL='neovide'

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### ALIASES ###
if [ -d "$HOME/.aliases" ] ;
  then source ~/.aliases/aliases
fi


# vsed = mix of vim and sed to interactively find and replaced in files
vsed() {
  search=$1
  replace=$2
  shift
  shift
  vim -c "bufdo! set eventignore-=Syntax|%s/$search/$replace/gce" **/*.$3
}


# # ex = EXtractor for all kinds of archives
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

## cd + ls ##
cl() {
  cd "$@" && ls
}

## interactivley cd ##
fcd() {
  local dir
  dir=$(find ~ -type d | fzf)
  if [[ -n $dir ]]; then
      cd "$dir"
  fi
}

fo() {
  local dir
  dir=$(find /run/media/Storage/omar/College -type d | fzf)
  if [[ -n $dir ]]; then
      cd "$dir"
  fi

}

bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

colorscript random
