# Enable zsh profiler
# zmodload zsh/zprof
# Add deno completions to search path

if [[ ":$FPATH:" != *":/home/omar/.zsh/completions:"* ]]; then export FPATH="/home/omar/.zsh/completions:$FPATH"; fi
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

# vi-mode
# set -o vi

# Starship prompt
eval "$(starship init zsh)"

# Use bat as the default manpager
export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Pager
# export PAGER='nvim +Man!'
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
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH:/opt/usr/bin/"
export PATH="$PATH:$HOME/.scripts/"
export PATH="$PATH:$HOME/.cache/lm-studio/bin"
export PATH="$PATH:$HOME/.cargo/bin/"
export ANDROID_HOME="$HOME/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

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

# Makes yazi change the cwd automatically when exiting
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function t() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}


# Function to get the top 10 most memory intensive processes
function topmem() {
    # Get total memory in KB (used for converting to MB)
    local scale=1024

    ps --no-headers -eo comm,rss | \
        awk -v scale="$scale" '
        {
            mem[$1] += $2
        }
        END {
            for (proc in mem)
                printf "%-20s %10.2f MB\n", proc, mem[proc]/scale
        }
        ' | sort -k2 -nr | head -n 10
}

# Funciton to get the most packages that take space on disk
function toppacman() {
  local n="${1:-10}"
  pacman -Qi | awk -F': ' '
    /^Name/ { name=$2 }
    /^Installed Size/ {
      s=$2; gsub(/^[ \t]+|[ \t]+$/,"",s)
      split(s,a," ")
      val=a[1]; unit=a[2]
      if (unit=="KiB") mult=1/1024
      else if (unit=="MiB") mult=1
      else if (unit=="GiB") mult=1024
      else mult=1
      printf("%.2f MiB\t%s\n", val*mult, name)
    }
  ' | sort -nr | head -n "$n"
}


# Interactive cd
function fcd() {
  local dir
  dir=$(fd --full-path ~/programming/ --type directory | fzf)
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

. "$HOME/.atuin/bin/env"

# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"
. "/home/omar/.deno/env"
# Print profiling results
# zprof
