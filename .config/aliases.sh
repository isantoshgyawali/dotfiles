#LINKS IN THE BROWSER
function url(){
	echo -n "URL : "
	read SITE
	firefox --new-window $SITE & disown
}

#-------------------
#  general_aliases  |
#-------------------
alias ll='ls -al'
alias upd='sudo dnf update --refresh && sudo dnf upgrade --refresh'
alias codx='code && exit'
alias br='firefox & disown'
alias gpt='xdg-open https://chat.openai.com & disown'

alias vi='nvim'
alias svi='sudo nvim'

alias yt='xdg-open https://youtube.com/ & disown'
alias ytd='youtube-dl'
alias tput='trash-put'
alias tls='trash-list'
alias tres='trash-restore'
alias r='ranger'
alias snake='nsnake'
alias top='bpytop'
alias ttype='ttyper -w 30'
alias df='duf'

alias e='exit'

alias fcp='xsel --clipboard < $(fzf)'
alias pwc='pwd | xsel --clipboard'
#---------------------
#  dir/files search   |
#---------------------
alias open='vi $( find $HOME -type f | fzf --preview "bat --color always {}")'
alias goto='cd $(find $HOME -type d | fzf) | ll; printf "\033c" && pwd'

alias ..='cd ..'
alias ...='cd ../..'

alias hf='history | fzf'

#-------------------
#  System Aliases   |
#-------------------
alias px='ps aux | fzf'

#-------------
#  git_quick  |
#-------------
alias isan='xdg-open https://github.com/isantoshgyawali/ & disown && exit'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gcob='git checkout -b'
alias gc='git checkout'
alias gbv='git branch -v'
alias gl='git log'
