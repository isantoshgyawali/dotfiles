# .zsh_profile
#------------------------
# ENVIROMENT - VARIABLES |
#------------------------
# -- golang & Android Studio ---
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export ANDROID_HOME="$HOME/Android/Sdk"

#-- js ecosystem ---
export N_PREFIX="$HOME/n" # n: node-package-manager
export PNPM_HOME="/home/cosnate/.local/share/pnpm"
export BUN_INSTALL="$HOME/.bun"

# Lazy load pyenv
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init --path)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}

typeset -U path
path=
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  /usr/local/go/bin
  $HOME/Android/Sdk/platform-tools
  $HOME/n/bin
  $HOME/.local/share/pnpm
  $HOME/.bun/bin
  $HOME/.pyenv/bin
  $HOME/bin
  $path
)
export PATH
