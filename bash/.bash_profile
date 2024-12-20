# .bash_profile
#------------------------
# ENVIROMENT - VARIABLES |
#------------------------
# --- cargo && go ---
export PATH="$HOME/.cargo/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# --- androidStudio ---
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# --- n : node-version-manager ---
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

#--- pnpm ---
export PNPM_HOME="/home/cosnate/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# --- bun ---
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# --- pyenv ---  
# [python version management]
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# eas-cli bash_completion
eval $(eas autocomplete:script bash)
