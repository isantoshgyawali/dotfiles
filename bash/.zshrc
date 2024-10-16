#DEFAULT EDITOR
export VISUAL=nvim;
export EDITOR=nvim;

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# --- prompt_config/UI ---
prompt_counter=0
set_prompt() {
    local git_branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    if (( prompt_counter > 0 )); then
        # Print a vertical space after each prompt execution (except the first)
        echo -e "\r\e[K"
    fi

    PROMPT='%F{8}%~%f'${git_branch}$'\n''%F{33}❯%f '
    ((prompt_counter++))
}
precmd() { set_prompt }
#-- Reset the prompt_counter after clear
alias clear='clear && prompt_counter=0'
alias ls="ls --classify --color=auto"

# --- bash_scripts & aliases ---
backups="$HOME/backups/bash"
dotfiles="$HOME/dotfiles/bash"

for dir in "$backups" "$dotfiles"; do 
    for file in "$dir"/*.sh; do
        [ -f "$file" ] && . "$file"
    done
done

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -Uz compinit && compinit

# zsh-plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# --- shell_integrations --- 
eval "$(fzf --zsh)"
