#---------------------
# BASH_CONFIGURATIONS |
#---------------------
#USER_SPECIFIC_ENVIROMENT
#-- checks if user's local binary directories ($HOME/.local/bin and $HOME/bin) are
#-- added to the beginning of the PATH variable if they are not already included
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

#SOURCE_GLOBAL_DEFINITION
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
source ~/.bash.env
shopt -s histappend

# HISTORY
HISTSIZE=5000
HISTFILESIZE=5000
export HISTCONTROL=ignoredups:erasedups
PROMPT_COMMAND='history -a'

#DEFAULT EDITOR
export VISUAL=nvim;
export EDITOR=nvim;

#UI_TWEAKS_bashrc [ BASH_PROMPT -> bin/ls/config ]
git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
set_prompt() {
    PS1='\[\e[1;90m\]\w\[\e[1;97m\]$(git_branch)\[\e[0m\]\n\[\e[38;5;33m\]❯\[\e[0m\] '
}
prompt_counter=0
#-- whenever the prompt_counter is greater than 0 ie. 
#-- if the prompt is not the first prompt it will print 
#-- a vertical space is printed after each prompt execution
PROMPT_COMMAND='if [ $prompt_counter -gt 0 ]; then echo -e "\r\e[K"; fi; ((prompt_counter++)); set_prompt'
#-- Reset the prompt_counter after clear
alias clear='clear && prompt_counter=0'

export LS_COLORS='di=38;5;63:fi=38;5;245:ex=38;5;40'
alias ls="ls --classify --color=auto"

# --- bash_scripts & aliases ---
backups="$HOME/backups/bash"
dotfiles="$HOME/dotfiles/bash"

for dir in "$backups" "$dotfiles"; do 
    for file in "$dir"/*.sh; do
        [ -f "$file" ] && . "$file"
    done
done
