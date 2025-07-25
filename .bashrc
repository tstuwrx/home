# bashrc

# if not interactive, do nothing
case $- in
*i*) ;; # interactive
*) return ;;
esac

# local utility functions
_have() { type "$1" &>/dev/null; }

# determine editor
export EDITOR='vi'
_have 'vim' && export EDITOR='vim'

# environment variables
export LANG=en_US.UTF-8
export TZ=America/Chicago
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export REPOS="$HOME/Repos"
export TERM=xterm-256color
export HRULEWIDTH=73
export VISUAL="$EDITOR"
export EDITOR_PREFIX="$EDITOR"
export HELP_BROWSER=lynx
# xdg standards
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
# coding
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export CFLAGS="-Wall -Wextra -Werror -O0 -g -fsanitize=address -fno-omit-frame-pointer -finstrument-functions"
export GOBIN="$HOME/.local/bin"
export GOPATH="$XDG_DATA_HOME/go"
export GOPROXY=direct
export CGO_ENABLED=0
# pager
export LS_COLORS="di=38;5;245:fi=38;5;223:ln=38;5;179:ex=38;5;108:*.txt=38;5;223"
export LESS="-FXR"
export LESS_TERMCAP_mb=$'\e[35m' # magenta
export LESS_TERMCAP_md=$'\e[1;33m' # yellow
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;108;1m' # blue
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'  # underline
export GROFF_NO_SGR=1
export GPG_TTY=$(tty)
# history
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

pathappend() {
  declare arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg:"/}
    export PATH="${PATH:+"$PATH:"}$arg"
  done
} && export -f pathappend

pathprepend() {
  declare arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg:"/}
    export PATH="$arg${PATH:+":${PATH}"}"
  done
} && export -f pathprepend

pathprepend \
    "$HOME/bin" \
    "$HOME/.local/go/bin" \
    "$HOME/.local/bin"

export CDPATH=".:$REPOS:$HOME"

# dictionary
[[ -d /.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

# pager

if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# dircolors
if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# bash shell options
shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s histappend

set -o vi
unalias -a
alias vi="$EDITOR"
alias ip='ip -c'
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias free='free -h'
alias df='df -h'
alias view='vi -R'
alias diff='diff --color'
alias clear='printf "\e[H\e[2J\e[3J"'
alias c='printf "\e[H\e[2J\e[3J"'

# prompt
PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
	local P='$' dir="${PWD##*/}" B countme short long double \
		r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
		u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
		b='\[\e[36m\]' x='\[\e[0m\]'

	[[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
	[[ $PWD = / ]] && dir=/
	[[ $PWD = "$HOME" ]] && dir='~'

        n=$(git rev-parse --show-toplevel 2>/dev/null)

	[[ $n = "$HOME" ]] || B=$(git branch --show-current 2>/dev/null)
	[[ $dir = "$B" ]] && B=.
	countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

	[[ $B == master || $B == main ]] && b="$r"
	[[ -n "$B" ]] && B="$g:$b$B$g"

	short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
	long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
	double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

	if ((${#countme} > PROMPT_MAX)); then
		PS1="$double"
	elif ((${#countme} > PROMPT_LONG)); then
		PS1="$long"
	else
		PS1="$short"
	fi
}
PROMPT_COMMAND="__ps1"
