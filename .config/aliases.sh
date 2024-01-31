#LINKS IN THE BROWSER
function url(){
	echo -n "URL : "
	read SITE
	firefox --new-window $SITE & disown
}

#-------------------
#  general_aliases  |
#-------------------
alias ll='ls -al --classify'
alias upd='sudo dnf update --refresh && sudo dnf upgrade --refresh'
alias br='firefox & disown'
alias gpt='xdg-open https://chat.openai.com & disown'
alias bing='firefox --private-window https://www.bing.com/chat && disown'

alias t='tmux'
alias c='code'
alias vi='nvim'
alias svi='sudo nvim'  

alias yt='xdg-open https://youtube.com/ & disown'
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

alias con='source $HOME/con'
alias key='xsel --clipboard < $HOME/key.txt'
alias fcp='xsel --clipboard < $(find ~ -type f | fzf)'

alias pwc='pwd | xsel --clipboard'

#tgpt 
alias tco='tgpt -c'
alias tim='tgpt -img'
alias tt='tgpt -i'

#-----------------------
#  dir/files navigate   |
#------------ ----------
alias open='vi `find $HOME -type f | fzf --height 50% --reverse --exact --preview "bat --color always {}"`'
alias goto='cd `find $HOME -type d | fzf --height 50% --reverse --exact`'

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
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status --short'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch -v'
alias gba='git branch -avv'

alias gl='git log'
alias gla='git log -a --decorate --oneline --graph'
alias glf='git log -n 5 --decorate --oneline --graph'
alias gcl='key && git clone'
alias gp='key && git push'

