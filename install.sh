#!/bin/bash
echo "dnf.conf updating.... "
sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf 
sudo echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf 
echo "dnf.conf updated"

# Define package groups
declare -A groups=(
    ["MAIN"]="git python3 make cargo nodejs gcc gcc-c++ fzf usbutils ffmpeg-free NetworkManager NetworkManager-wifi"
    ["BASIC"]="tmux neovim firefox kitty ranger trash-cli btop duf sxiv mpv thunar cronie wl-clipboard"
    ["FUN"]="cowsay cmatrix nsnake"
    ["GNOME"]="gnome-shell gnome-extensions gnome-tweaks"
    ["I3"]="i3 i3-gaps picom polybar"
    ["hypr"]="hyprland waybar wlogout swaylock rofi-wayland network-manager-applet blueman pavucontrol"
)

install_packages() {
    local pkgs="$1"
    sudo dnf install $pkgs
}

display_checkboxes() {
    echo "Select groups to install packages (press Enter to install selected packages):"
    for group in "${!groups[@]}"; do
        if [[ " ${selected_groups[@]} " =~ " $group " ]]; then
            echo "[*] $group : (${groups[$group]})"
        else
            echo "[ ] $group : (${groups[$group]})"
        fi
    done
}

# Main function
declare -a selected_groups=()
clear
display_checkboxes

# Loop for user input
while true; do
    read -rp "Enter the group you want to toggle (press Enter to install): " choice
    if [[ -z $choice ]]; then
        break
    elif [[ ! ${groups[$choice]} ]]; then
        echo "Invalid group!"
        continue
    fi

    if [[ " ${selected_groups[@]} " =~ " $choice " ]]; then
        selected_groups=("${selected_groups[@]/$choice}")
    else
        selected_groups+=("$choice")
    fi

    # Clear screen and display checkboxes with selections
    clear
    display_checkboxes
done

# Install selected packages
pkgs_to_install=""
for group in "${selected_groups[@]}"; do
  pkgs_to_install="${pkgs_to_install} ${groups[$group]}"
done
install_packages "$pkgs_to_install"


#FILE SYSTEM
mkdir -p ~/{phone,projects/ps,Pictures/Screenshots,.config}
touch ~/key.txt
git clone https://github.com/isantoshgyawali/dotfiles
cd ~/dotfiles/
rm -rf ~/.bashrc
ln bash/.bashrc ~/
ln bash/.bash_profile ~/
cp -r config/{waybar,nvim,tmux,kitty,ranger,hypr} ~/.config/

cd ~/projects/
git clone https://github.com/isantoshgyawali/Let-it-GO
git clone https://github.com/isantoshgyawali/mate.

#TPM INSTALL 
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/tpm

#POSTGRES SETUP
sudo dnf install postgresql16 postgresql16-server postgresql16-contrib
sudo postgresql-setup --initdb
sudo adduser testdb
sudo -u postgres createdb testdb
#PG_CLI - SETUP
cd ~/projects/ps/
python -m venv myenv
pip install --upgrade pip
pip install pgcli 

#NETWORK SETTINGS
sudo nmcli radio wifi on 
sudo systemctl restart NetworkManager
echo "*/30 * * * * /home/cosnate/backups/bash/other/wallpaper.sh" > ~/cron
sudo systemctl start crond
crontab -e

sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8082/tcp --permanent
sudo firewall-cmd --reload
