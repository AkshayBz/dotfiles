* Connect to WiFi
```
wifi-menu
```
* Might have to start dhcpd in another tty if ping doesn't work. (Atl + Arrow to switch tty)
```
dhcpd
```
* Update clock
```
timedatectl set-ntp true
```

* Mount partition on which arch is to be installed (`fdisk -l` to detect)
```
mount /dev/sdX1 /mnt
```

* Update mirror list (Move geo closer servers to the top)
```
nano /etc/pacman.d/mirrorlist
```

* Install base packages
```
pacstrap /mnt base base-devel dialog sudo zsh wpa_supplicant xorg-server xorg-init mesa i3-gaps \
  firefox-develop-edition xorg-xev \
  git alacritty neovim htop
```

* Generate fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```

* Chroot into new system

arch-chroot /mnt

* Timezone

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

* Uncomment en_US.UTF-8 UTF-8 and other needed locales in /etc/locale.gen, and generate them with
locale-gen

```
/etc/locale.conf
LANG=en_US.UTF-8
```

```
/etc/hostname
Envyous
```

```
/etc/hosts
127.0.0.1 Envyous envyous
```

* Set root password
```
passwd
```

* Add user
```
useradd -m -G wheel -s /usr/bin/zsh akshay
```

* Add to sudoers
```
Type `visudo` and uncomment this line: # %wheel ALL=(ALL) ALL
```

* Setup your booloader at this step. Skipping as I already have a working GRUB install, ref: https://wiki.archlinux.org/index.php/installation_guide#Initramfsa

* Reboot and login to system as user

* Config X server & i3

```
~/.xinitrc
exec i3
```

* Start i3
```
startx
```

* Open this gist in browser so that you can copy paste things now :D

* Create Swap file
```
truncate -s 0 /swapfile
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
echo 'vn.swappiness=0' > /etc/sysctl.d/99-sysctl.conf
```

* Autostart systemd default session on tty1
```
~/.zprofile
# autostart systemd default session on tty1
if [[ "$(tty)" == '/dev/tty1' ]]; then
    exec startx
fi
```

* Install yay, AUR helper
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

* Fan speed control
```
yay -S nbsp-git
systemctl enable nbfc --now
nbfc config -a "HP ENVY x360 Convertible 13-ag0xxx"  # Change this if not installing on HP Envy 13
```
* _Any error? Check this: https://wiki.archlinux.org/index.php/Fan_speed_control#Configuration_2_


## TODO

# Unbound for DNS resolution
* https://wiki.archlinux.org/index.php/Unbound

# Light DM Greeter, might wanna skip for now to keep things lightweight
* https://github.com/NoiSek/Aether

# Notification Deamon
* https://wiki.archlinux.org/index.php/Dunst

# Pywal for colors
* https://github.com/dylanaraps/pywal/wiki/Getting-Started
* pacman -S python-pywal

# Rotating wallpapers
* pacman -S feh
* feh --randomize --bg-fill ~/Pictures/Wallpapers/* &  # Add this to .xinitrc

# Polybar
* yay -S polybar
https://wiki.archlinux.org/index.php/Polybar

# Rofi
* https://github.com/davatorium/rofi

# Power management related stuff like tlp, acpi events, hibernation

# Sound, Video codecs
# Touchpad

# Old stuff like pyenv, nvm, mosh, AWS CLI etc
