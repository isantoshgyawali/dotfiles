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

#HISTSIZE
HISTSIZE=5000
HISTFILESIZE=5000

#DEFAULT EDITOR
export VISUAL=nvim;
export EDITOR=nvim;

#UI_TWEAKS_bashrc [ BASH_PROMPT -> bin/ls/config ]
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\[\e[1;90m\]\w\[\e[1;97m\]$(parse_git_branch)\[\e[0m\]\n\[\e[38;5;10m\]$\[\e[0m\] '

#-----------------------
# PROMPT_VERTICAL_SPACE |
# ----------------------
prompt_counter=0
#-- Reset the prompt_counter after clear
alias clear='clear && prompt_counter=0'

#-- whenever the prompt_counter is greater than 0 ie. 
#-- if the prompt is not the first prompt it will print 
#-- a vertical space is printed after each prompt execution
#
#-- "THIS IS A VERY SILLY ISSUE AND ASSUME 99.99% OF FOLKS DON'T NEED THIS"  
PROMPT_COMMAND='if [ $prompt_counter -gt 0 ]; then echo -e "\r\e[K"; fi; ((prompt_counter++))'

export LS_COLORS='di=38;5;63:fi=38;5;245:ex=38;5;40'
export LS_COLORS

alias ls="ls --classify --color=auto"

#CUSTOM_BASH_SCRIPTS_ITERATIONS
source ~/.bash.env
for file in ~/dotfiles/bash/*.sh; do 
	[ -f "$file" ] && . "$file"
done

for file in ~/backups/bash/*.sh; do 
	[ -f "$file" ] && . "$file"
done
