
lsblk
sudo dd if=/home/echo/Downloads/archlinux-2026.05.01-x86_64.iso of=/dev/sda bs=4M status=progress oflag=sync
sync

# sudo wipefs -a /dev/sdX

##################################
################################## 

ping archlinux.org
archinstall
# Use a best-effort default partition layout
# ext4
# systemd-boot
# Swap on zram
# hostname: arch-desktop
# User account: echo sudo
# profile minimal
# audio PipeWire
# NetworkManager
# vim git base-devel linux-headers
# kernel: linux
# GPU: NVIDIA proprietary

##################################
################################## 

sudo pacman -Syu
# git clone https://github.com/JaKooLit/Arch-Hyprland
# chmod +x ./install.sh

