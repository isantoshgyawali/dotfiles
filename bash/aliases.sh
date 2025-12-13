#-------------------
#  general_aliases  |
#-------------------
alias la='ls -a'
alias ll='ls -al --classify'
alias sb='source $ZDOTDIR/.zshrc $ZDOTDIR/.zprofile'
alias upd='sudo dnf update --refresh && sudo dnf upgrade --refresh'
alias pwc='pwd | wl-copy'
alias open='xdg-open'
alias e='exit'
alias key='cat ~/key | wl-copy'
alias nt='nmtui'

alias t='tmux'
alias c='code'
alias vi='nvim'
alias s='scrcpy --no-audio'
alias gpt='firefox https://chat.openai.com & disown'
alias bing='firefox --private-window https://www.bing.com/chat && disown'

alias y='yazi'
alias top='btop'
alias tls='trash-list'
alias tput='trash-put'
alias tres='trash-restore'
alias snake='nsnake'
alias ttype='ttyper -w 30'

alias fcp='cat $(find ~/{projects,backups,dotfiles,.config} $HOME -type f| fzf --height 69% --exact --reverse --preview "bat --color always {}") | wl-copy'

#-----------------------------
# Terminal Narrative/Neo Mode
#-----------------------------
function tnm() {
    local SPEED=10 TEXT rows cols row col
    command clear

    if [[ "$1" =~ '^[0-9]+$' ]]; then
      SPEED="$1"
      shift
    fi

    # Read from stdin if piped
    if [[ -p /dev/stdin ]]; then
        TEXT="$(cat)"
    else
        TEXT="$*"
    fi

    rows=$(command tput lines)
    cols=$(command tput cols)
    row=$(( rows / 2 ))
    col=$(( (cols - ${#TEXT}) / 2 > 0 ? (cols - ${#TEXT}) / 2 : 0 ))

    command tput cup $row $col
    echo -n "$TEXT" | pv -qL "$SPEED"

    # hide cursor afterwards
    # command tput civis
    # cursor is restored on exit (Ctrl-C, normal exit, etc.)
    # trap 'command tput cnorm; return' INT TERM

    # Wait forever until Ctrl-C
    while :; do sleep 1; done
}

#-----------
# dir/files |
#-----------
alias flf='du -shx -- * | sort -rh | head -10' #prints out the top 10 largest files in current dir 

#directories def'n for prioritzation
function o() {
    local firstPriority=$([ "$PWD" != "$HOME" ] && echo "$PWD" || echo "")
    local find_command="find $ZDOTDIR/.zshrc ${firstPriority:+$firstPriority} $HOME/{projects,backups,dotfiles,.config,Downloads} $HOME" 
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
        ".local/share/waydroid"
    )

    for exclude in "${excludes[@]}"; do
        find_command+=" -path \"*/$exclude/*\" -prune -o"
    done
    find_command+=" -type f -print"

    eval "$find_command" | fzf --height 69% --reverse --exact --preview "bat --color always {}" | xargs -r nvim
}

function g() {
    local selected_dir
    local firstPriority=$([ "$PWD" != "$HOME" ] && echo "$PWD" || echo "")
    local find_command="find $ZDOTDIR/.zshrc ${firstPriority:+$firstPriority} $HOME/{projects,backups,dotfiles,.config,Downloads} $HOME" 
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
        ".local/share/waydroid"
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
    local firstPriority=$([ "$PWD" != "$HOME" ] && echo "$PWD" || echo "")
    local find_command="find $ZDOTDIR/.zshrc ${firstPriority:+$firstPriority} $HOME/{projects,backups,dotfiles,.config,Downloads} $HOME" 
    local excludes=(
        "node_modules"
        "Android"
        "go"
        "phone"
        ".git"
        ".local/share/waydroid"
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

alias hf='cmd=$(fc -rl 1 | fzf --reverse --height 50% --exact | sed "s/^[ ]*[0-9]*[ ]*//"); if [ -n "$BASH_VERSION" ]; then history -s "$cmd"; elif [ -n "$ZSH_VERSION" ]; then print -s "$cmd"; fi; echo "$cmd"; eval "$cmd"'

#-------------------
#  System Aliases   |
#-------------------
alias shut='systemctl poweroff'
alias reo='systemctl reboot' 
alias px='ps aux | fzf'

alias spq='sudo systemctl start postgresql'
alias rpq='sudo systemctl restart postgresql'
alias xpq='sudo systemctl stop postgresql'

alias bto='rfkill unblock bluetooth && bluetoothctl power on && bluetoothctl connect BE:36:5C:BA:2C:FD'
alias btc='bluetoothctl power off' 

function pk(){
    #-- get the PID of the selected process
    selected_pid=$(ps aux | fzf --multi --header='[Use Tab to select multiple processes]' --reverse --height 70% | awk '{ print $2 }' | tr '\n' ' ' | sed 's/ $//')

    #-- checks if a PID is selected
    if [ -n "$selected_pid" ]; then
        if [ -n "$ZSH_VERSION" ]; then
            read "confirmation?Are you sure you want to kill the selected process(es) (PIDs: $selected_pid)? (y/n): "
        else
            read -p "Are you sure you want to kill the selected process(es) (PIDs: $selected_pid)? (y/n): " confirmation
        fi

        if [ "$confirmation" = "y" ]; then
            for pid in ${=selected_pid}; do
                kill -9 $pid
            done
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
function isan(){
    if [ -n "$1" ]; then
        xdg-open https://github.com/isantoshgyawali/$1 & disown
    else
        xdg-open https://github.com/isantoshgyawali/ & disown
    fi
}
alias ga='git add .'
alias gac='git add . && git commit -m'
alias gc='git commit -m'
alias gs='git status --short'
alias gd='git diff'

alias gu='git reset --soft HEAD~1 && git restore --staged .'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch -v'
alias gba='git branch -avv'

alias gl='git log'
alias gla="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias glf='git log -n 5 --decorate --oneline --graph'
alias gcl='git clone'
alias gpl='git pull'
alias gp='git push'

alias lg='lazygit'

#---------------------------------------
#  others - generally project specific  |
#---------------------------------------
alias vne='source $HOME/projects/ps/myenv/bin/activate'
alias gor="go run ./cmd/main/main.go"
alias gob="go build ./cmd/main/main.go"
