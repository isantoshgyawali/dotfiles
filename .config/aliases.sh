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
alias gpt='xdg-open https://chat.openai.com & disown && exit'
alias vi='nvim'
alias yt='xdg-open https://youtube.com/ & disown && exit'
alias ytdown='youtube-dl'
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
alias goto='cd $(find $HOME -type d | fzf); printf "\033c" && pwd'

alias hf='history | fzf'

#-------------
#  git_quick  |
#-------------
alias isan='xdg-open https://github.com/isantoshgyawali/ & disown && exit'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'

