# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything

if [ -f ~/.py3env/bin/activate ]; then
    source ~/.py3env/bin/activate
fi

export EDITOR="/usr/bin/vim"
export LC_CTYPE=zh_CN.UTF-8 # 可以輸入UTF-8中文
export LC_MESSAGES=zh_CN.UTF-8 # 可以顯示UTF-8中文

case $- in
    *i*) ;;
      *) return;;
esac
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export TERM='xterm-256color'
export PS1="\[\e[32;1m\]\u \w \[\e[0m\]"


[[ -s /home/dev/.autojump/etc/profile.d/autojump.sh ]] && source /home/dev/.autojump/etc/profile.d/autojump.sh

if [ -f ~/.tmux_default ]; then
    ~/.tmux_default > /dev/null 2>&1 
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
export PATH=~/.py3env/bin/:/usr/local/bin/:$PATH
