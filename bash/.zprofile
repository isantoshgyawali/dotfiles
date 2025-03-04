# .zprofile
#------------------------
# ENVIROMENT - VARIABLES |
#------------------------
# --- dotfiles binary ---
export PATH="$HOME/dotfiles/bin:$PATH"

# --- cargo && go ---
export PATH="$HOME/.cargo/bin:$PATH"

#--- gvm : go-version manager ---
[[ -s "/home/cosnate/.gvm/scripts/gvm" ]] && source "/home/cosnate/.gvm/scripts/gvm"
unset -f cd
export PATH="$HOME/go/bin:$PATH"

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
# lazy-loading: pyenv [python version manager]
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init --path)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}
