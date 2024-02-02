#-- switch to the specific window
win (){
 wmctrl -s "$1"
}

#-- youtube search
function yt(){
	read -p "Search: " search_query

	#-- checking if the input is available
	if [ -z "$search_query" ]; then
		echo "Please provide a search query."
		return 1
	fi

  #-- sed checks the space and replace it with + globally
  #-- and encoded query is constructed
  encoded_query=$(echo "$search_query" | sed 's/ /+/g')
 
  wmctrl -s 1 
  youtube_url="https://www.youtube.com/results?search_query=$encoded_query"
  xdg-open "$youtube_url" > /dev/null 2>&1
}

#-------------------
#  general_aliases  |
#-------------------
alias ll='ls -al --classify'
alias upd='sudo dnf update --refresh && sudo dnf upgrade --refresh'
alias br='win 1 | firefox > /dev/null 2>&1 & disown'
alias gpt='win 1 | firefox https://chat.openai.com & disown'
alias bing='win 1 | firefox --private-window https://www.bing.com/chat && disown'

alias t='tmux'
alias c='code'
alias vi='nvim'

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

alias fcp='xsel --clipboard < $(find ~ -type f | fzf)' 	#-- copies the file content 
alias pwc='pwd | xsel --clipboard' 			#-- copies the current path to sysClipboard

#tgpt 
alias tco='tgpt -c'
alias tim='tgpt -img'
alias tt='tgpt -i'

#-----------------------
#  dir/files navigate   |
#------------ ----------
alias o='find $HOME -type f | fzf --height 69% --reverse --exact --preview "bat --color always {}" | xargs -r nvim'
alias g='cd `find $HOME -type d | fzf --height 69% --reverse --exact`'

alias ..='cd ..'
alias ...='cd ../..'

alias hf='eval "$(history | fzf --reverse --height 50% --exact | sed "s/^[ ]*[0-9]*[ ]*//")"'

#-------------------
#  System Aliases   |
#-------------------
alias px='ps aux | fzf'

function pk(){
#-- get the PID of the selected process
selected_pid=$(ps aux | fzf --multi --header='[Use Tab to select multiple processes]' --reverse --height 70% | awk '{print $2}')

#-- checks if a PID is selected
if [ -n "$selected_pid" ]; then
  read -p "Are you sure you want to kill the selected process (PID: $selected_pid)? (y/n): " confirmation

  if [ "$confirmation" == "y" ]; then
    kill -9 $selected_pid
    echo "Process (PID: $selected_pid) killed."
  else
    echo "Process not killed."
  fi
else
  echo "No process selected."
fi
}

#-------------
#  git_quick  |
#-------------
alias isan='win 1 | xdg-open https://github.com/isantoshgyawali/ & disown && exit'
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
alias gp='git push'

