# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lah --color=auto'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[1;36m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] > "

alias svstatus="sudo sv status /var/service/*"
