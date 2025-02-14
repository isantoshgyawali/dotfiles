{
  description = "Temporary Development enviroment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with nixpkgs.legacyPackages.${system}; [
            git
            zsh
            neovim
            tmux
            fzf
            tree
            btop
            ripgrep
            stow
        ];

        shellHook = ''
            echo "Welcome to Temporary Nixi-[fied] enviroment."
            echo "--------------------------------------------"
            echo "\n"

            echo "Setting Home to current dir for better isolation"
            export HOME=${pwd}

            echo "setting zsh up"
            chsh -s $(which zsh)

            echo "Creating directories : [.config, backups, projects]"
            echo "Cloning and Linking dotfiles"
            git clone https://github.com/isantoshgyawali/dotfiles
            ln -s ~/dotfiles/config/bash/.zshrc ~/.zshrc
            ln -s ~/dotfiles/config/bash/.zprofile ~/.zprofile

            echo "Installing tpm : [tmux-plugin-manager]"
            git clone https://github.com/tmux-plugins/tpm ~/sg/.tmux/plugins/tpm


            echo "Installing go1.24 && go1.23 using gvm [Go version manager]"
            bash < <(curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

            [[ -s "$HOME/scripts/gvm" ]] && source "$HOME/scripts/gvm"

            gvm install go1.24
            gvm use go1.23 --default
            go version
        '';
      };
    };
}
