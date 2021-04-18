# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias general
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\033[1;32m\]\W\[\033[33m\]\$(git_branch)\[\033[00m\] > "

# Alias Runit
alias svs='sudo sv status /var/service/*'

# Alias XBPS
alias xup='sudo xbps-install -Su'
alias xin='sudo xbps-install -S'
alias xrmd='sudo xbps-remove -R'
alias xrm='sudo xbps-remove'
alias xse='xbps-query -Rs'
alias xry='xbps-query -s'
alias Xse='xbps-query -RX'
alias Xry='xbps-query -X'
