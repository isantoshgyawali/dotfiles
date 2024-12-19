#-- checks if user's local binary directories ($HOME/.local/bin and $HOME/bin) are
#-- added to the beginning of the PATH variable if they are not already included
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

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
    local git_branch=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        git_branch=" ($git_branch)"
    fi

    # Add the virtual environment name if active
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="($(basename $VIRTUAL_ENV)) "
    fi

    # local git_branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    if (( prompt_counter > 0 )); then
        # Print a vertical space after each prompt execution (except the first)
        echo -e "\r\e[K"
    fi
    PROMPT='%F{8}%~%f '${venv}${git_branch}$'\n''%F{33}❯%f '
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
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# zsh-plugins
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  Aloxaf/fzf-tab

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
