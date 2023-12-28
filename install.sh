#!/bin/bash


#----------------------#
# Installation Script  |
#----------------------#


basePackages=(

	"git"
	"python3"
	"cargo"
	"usbutils"
	"NetwoorkManager"
	"NetworkManager-cli"
)

generalPackages=(

	"kitty"
	"neovim"
	"tmux"
	"ranger"
	"fzf"
	"trash-cli"
	"bpytop"

	"vlc"
	"ffmpeg"
	"mpv"
	"sxiv"
)

funPackages=(

	"Neofetch"
	"cmatrix"
	"cowsay"
	"cava"
)




if [[ $EUID -ne 0 ]]; then
    
    sudo -v  
      exec sudo "$0" "$@"  
    exit 1
  
fi


#--------------------------
# Defining Package Manager |
#--------------------------

package_managers=(

    ["apt-get"]="-y install"
    ["pacman"]="-S"
    ["dnf"]="-y install"

)


for package_manager in "${!package_managers[@]}"; do

    if command -v "$package_manager" &> /dev/null; then

        echo "Using package manager: $package_manager"
        install_command="${package_managers[$package_manager]}"
        break

    fi

done

# Exit if no supported package manager is found
if [ -z "$package_manager" ]; then
    echo "Error: No supported package manager found."
    exit 1
fi

#---------------------
# Installing Packages |
#---------------------

"$package_manager" $install_command cowsay

for level in "base" "general" "fun"; do
 
	packages=("${!level}Packages[@]")
	
	echo -e "\n${level^} Packages: "
	cowsay -tux "${packages[@]// /, }"

	read -p "Install ${level} packages?(y/n) :" choice
	
	if [[ "$choice" =~ ^[Yy]es$ ]]; then
		
		trap 'error_handler' ERR
		    sudo "$package_manager" $install_command "${packages[@]}"
		trap - ERR
	fi
done

echo "Installation successfull!"


#---------------
# Error Handler |
#---------------

error_handler() {
    echo -e "\n\nInstallation interrupted! An error occurred."
    echo "Please review the output above for details."
    echo "You might need to retry the installation or troubleshoot manually."
}

























