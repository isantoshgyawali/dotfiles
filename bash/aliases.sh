#-- youtube search
function yt(){
	read -p "search: " search_query

	#-- checking if the input is available
	if [ -z "$search_query" ]; then
		xdg-open "https://www.youtube.com/" > /dev/null 2>&1 & disown
                return 1
	fi

  #-- sed checks the space and replace it with + globally
  #-- and encoded query is constructed
  encoded_query=$(echo "$search_query" | sed 's/ /+/g')
  youtube_url="https://www.youtube.com/results?search_query=$encoded_query"
  xdg-open "$youtube_url" > /dev/null 2>&1 & disown
}

#-------------------
#  general_aliases  |
#-------------------
alias la='ls -a'
alias ll='ls -al --classify'
alias sb='source ~/.bashrc && source ~/.bash_profile'
alias upd='sudo dnf update --refresh && sudo dnf upgrade --refresh'
alias gpt='firefox https://chat.openai.com & disown'
alias bing='firefox --private-window https://www.bing.com/chat && disown'
alias gemini='firefox https://gemini.google.com/ && disown'

alias t='tmux'
alias c='code'
alias vi='nvim'
alias s='scrcpy --no-audio'

alias tput='trash-put'
alias tls='trash-list'
alias tres='trash-restore'
alias r='ranger'
alias snake='nsnake'
alias top='btop'
alias ttype='ttyper -w 30'

alias e='exit'

alias key='cat $HOME/key.txt | wl-copy'
alias fcp='cat $(find ~/{projects,backups,dotfiles,.config} $HOME -type f| fzf --height 69% --exact --reverse --preview "bat --color always {}") | wl-copy'

alias pwc='pwd | wl-copy'

alias vne='source ./myenv/bin/activate'

#-----------
# dir/files |
#-----------
alias flf='du -shx -- * | sort -rh | head -10' #prints out the top 10 largest files in current dir 

#directories def'n for prioritzation
function o() {
    local find_command="find ~/.${SHELL##*/}rc ~/{projects,backups,dotfiles,.config} $HOME"
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
    )

    for exclude in "${excludes[@]}"; do
        find_command+=" -path \"*/$exclude/*\" -prune -o"
    done
    find_command+=" -type f -print"

    eval "$find_command" | fzf --height 69% --reverse --exact --preview "bat --color always {}" | xargs -r nvim
}

function g() {
    local selected_dir
    local find_command="find ~/{projects,backups,dotfiles,.config} $HOME"
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
    )

    for exclude in "${excludes[@]}"; do
        find_command+=" -path \"*/$exclude/*\" -prune -o"
    done
    find_command+=" -type d -print"

    # Only cd if a directory was selected
    selected_dir=$(eval "$find_command" | fzf --height 69% --reverse --exact)
    if [[ -n $selected_dir ]]; then
        cd "$selected_dir" 
    fi
}

function v() {
    local selected_dir
    local find_command="find ~/{projects,backups,dotfiles,.config} $HOME"
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
    )

    for exclude in "${excludes[@]}"; do
        find_command+=" -path \"*/$exclude/*\" -prune -o"
    done
    find_command+=" -type d -print"

    # Only open nvim if a directory was selected
    selected_dir=$(eval "$find_command" | fzf --height 69% --reverse --exact)
    if [[ -n $selected_dir ]]; then
        cd "$selected_dir" && nvim .
    fi
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias hf='cmd=$(history | fzf --reverse --height 50% --exact | sed "s/^[ ]*[0-9]*[ ]*//");history -s "$cmd"; echo $cmd; eval "$cmd"'

#-------------------
#  System Aliases   |
#-------------------
alias shut='systemctl poweroff'
alias reo='systemctl reboot' 
alias px='ps aux | fzf'

alias bto='rfkill unblock bluetooth && bluetoothctl power on && bluetoothctl connect 11:F5:BD:C2:3C:D4'
alias btc='bluetoothctl power off && rfkill block bluetooth'

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

#BACKLIGHT 
alias lto="sudo ~/config/backlit/lightson.sh"

#MOUNTING PHONE'S STORAGE ft. sshfs
alias phone="sshfs -p 8022 $DEV:/storage/emulated/0/ ~/phone/"

#-------------
#  git_quick  |
#-------------
alias isan='xdg-open https://github.com/isantoshgyawali/ & disown'
alias ga='git add .'
alias gac='git add . && git commit -m'
alias gc='git commit -m'
alias gs='git status --short'
alias gd='git diff'

alias gu='git reset --soft HEAD~1'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch -v'
alias gba='git branch -avv'

alias gl='git log'
alias gla="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias glf='git log -n 5 --decorate --oneline --graph'
alias gcl='key && git clone'
alias gpl='key && git pull'
alias gp='key && git push'

alias lg='lazygit'

#---------------------------------------
#  others - generally project specific  |
#---------------------------------------
alias gor="go run ./cmd/main/main.go"
alias gob="go build ./cmd/main/main.go"

function cl(){
	read -p "Enter port:" port
	read -p "path:" path

	#-- if the port is empty assign the default value 8081 and if not then uses the $port
	#-- checks if the path is empty and if not then adds the $path else leave it
	url="localhost:${port:=8080}/${path:+$path/}"
	curl "$url"
}
