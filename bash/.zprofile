# .zprofile
# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

#------------------------
# ENVIROMENT - VARIABLES |
#------------------------
# --- dotfiles binary ---
export PATH="$HOME/dotfiles/bin:$PATH"

# --- cargo && go ---
export PATH="$HOME/.cargo/bin:$PATH"

#--- gvm : go-version manager ---
[[ -s "/home/cosnate/.gvm/scripts/gvm" ]] && source "/home/cosnate/.gvm/scripts/gvm"
# unset -f cd
export PATH="$HOME/go/bin:$PATH"

# --- androidStudio ---
export ANDROID_USER_HOME=$HOME/.config/.android
export ANDROID_AVD_HOME=$HOME/.config/.android/avd
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

export JAVA_HOME=/usr/lib/jvm/jdk-21.0.12.1-oracle-x64
export PATH="$JAVA_HOME/bin:$PATH"

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
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
