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

* (Optional) Separate home partition?
```
mount /dev/sdX2 /mnt/home
```

* (Optional) Separate boot partition and want to install a bootloader?
```
mount /dev/sdX3 /mnt/boot
```

* Update mirror list (Uncomment & move geo closer servers to the top)
```
nano /etc/pacman.d/mirrorlist
```

* Install base packages
```
pacstrap /mnt base base-devel sudo
```

* Generate fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```

* Chroot into new system

```
arch-chroot /mnt
```

* Timezone
```
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
```

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
useradd -m -G wheel -s /usr/bin/zsh akshay && passwd akshay
```

* Add to sudoers
```
Type `visudo` and uncomment this line: # %wheel ALL=(ALL) ALL
```

* Setup your booloader at this step. Skipping as I already have a working GRUB install, ref: https://wiki.archlinux.org/index.php/installation_guide#Initramfsa

* Reboot and login to system as user

* Install additional packages
```sh
sudo pacman -S dialog zsh \
  compton i3-gaps xorg-server xorg-xinit \
  firefox-developer-edition xorg-xev git \
  kitty neovim htop \
  mesa
```

* (Optional) Nvidia Graphics
```sh
sudo pacman -S nvidia bbswitch nvidia-xrun
```

* Disable nvidia start on boot using bbswitch
```
# /etc/modprobe.d/bbswitch.conf
options bbswitch load_state=0 unload_state=1
```
```
# /etc/modules-load.d/bbswitch.conf
bbswitch
```

* Config X server & i3

```
# ~/.Xresources
Xft.dpi: 166
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
```

```
# ~/.xinitrc
xrdb -merge ~/.Xresources
[ -f ~/.cache/wal/colors.Xresources ] && xrdb -merge ~/.cache/wal/colors.Xresources
xrandr --dpi 166
exec i3
```

* Start i3
```
startx  # Or, `nvidia-xrun i3` if you wanna use that GPU
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

# Fan speed control
```
yay -S nbfc-git
systemctl enable nbfc --now
nbfc config -a "HP ENVY x360 Convertible 13-ag0xxx"  # Change this if not installing on HP Envy 13
```

Run these commands if you get `File Descriptor does not support writing`
```sh
sudo mv /opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll /opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll.old
sudo systemctl restart nbfc
```

Resources:
* https://wiki.archlinux.org/index.php/Fan_speed_control#Configuration_2


# TLP
```sh
sudo pacman -S tlp
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
```

Resources:
* https://wiki.archlinux.org/index.php/TLP


# Networking (Network Manager, Resolvconf, Dnsmasq for local domain resolution)
* Install required utils
```sh
sudo pacman -S resolvconf dnsmasq networkmanager iwd  # network-manager-applet nm-connection-editor
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

* List and connect to network
```sh
nmcli device wifi list
nmcli device wifi connect <ssid> password <password>
```

* Configure the tools
```conf
# /etc/resolvconf.conf
name_servers="::1 127.0.0.1"

# Write out dnsmasq extended configuration and resolv files
dnsmasq_conf=/etc/dnsmasq-openresolv.conf
dnsmasq_resolv=/etc/dnsmasq-resolv.conf
```

```conf
# /etc/dnsmasq.conf
address=/local/127.0.0.1
listen-address=::1,127.0.0.1
cache-size=1500
conf-file=/etc/dnsmasq-openresolv.conf
resolv-file=/etc/dnsmasq-resolv.conf
strict-order
server=1.1.1.1
server=8.8.8.8
server=8.8.4.4
```

```conf
# /etc/NetworkManager/conf.d/rc-manager.conf
[main]
rc-manager=resolvconf
```

* (Optional) Use iwd as WiFi backend
```conf
# /etc/NetworkManager/conf.d/wifi_backend.conf
[device]
wifi.backend=iwd
```

```sh
sudo resolvconf -u
sudo systemctl start dnsmasq.service
sudo systemctl enable dnsmasq.service
```

Resources:
* https://wiki.archlinux.org/index.php/Openresolv
* https://wiki.archlinux.org/index.php/Dnsmasq
* https://wiki.archlinux.org/index.php/NetworkManager#Use_openresolv
* https://wiki.archlinux.org/index.php/Iwd

# Docker
```sh
sudo pacman -S docker docker-compose
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
```

Resources:
* https://wiki.archlinux.org/index.php/Docker
* https://docs.docker.com/install/linux/linux-postinstall

# Pyenv

Resources:
* https://github.com/pyenv/pyenv


# Sound

```sh
sudo pacman -S pulseaudio alsa-utils
```

Control using multimedia keys:

```conf
# ~/.config/i3/config
bindsym XF86AudioRaiseVolume exec --no-startup-id amixer set Master 5%+
bindsym XF86AudioLowerVolume exec --no-startup-id amixer set Master 5%-
# bindsym XF86AudioMute exec --no-startup-id amixer set Master toggle
# Using pactl because: https://superuser.com/questions/805525/why-is-unmute-not-working-with-amixer-command
bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
```

Resources:
* https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture
* https://wiki.archlinux.org/index.php/PulseAudio#Keyboard_volume_control

# Touchpad

* One time setup:

```conf
# /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingButtonMap" "lrm"  # 1/2/3 finger tap => left right middle clicks
EndSection
```

* (Optional) If values to be updated during runtime:

```sh
sudo pacman -S libinput xorg-xinput # Required for setting options at runtime in X
xinput list
xinput list-props <device-id>
xinput set-prop <device-id> <option-number> <value>
```

For example, to enable taps:

```sh
$ xinput list-props 11
Device 'SynPS/2 Synaptics TouchPad':
  ...
  libinput Tapping Enabled (287): 0
  ...

$ xinput set-prop 11 287 1
```

# Backlight
```sh
sudo pacman -S light
```

Control using multimedia keys:

```conf
# ~/.config/i3/config
bindsym XF86MonBrightnessUp exec light -A 5
bindsym XF86MonBrightnessDown exec light -U 5
```

Resources:
* https://github.com/haikarainen/light


# Lockscreen
```sh
yay -S i3lock-color
sudo pacman -S xss-lock # To enable auto lock on suspend/hibernate
```

Resources:

* ~/.config/i3/config
* ~/.config/i3/scripts/lock.sh
* https://github.com/PandorasFox/i3lock-color


# Application launcher (Rofi)
```sh
sudo pacman -S rofi
```

```conf
# ~/.config/i3/config
bindsym $mod+d exec --no-startup-id rofi -show combi
```

Resources:
* ~/.config/rofi/config
* https://github.com/davatorium/rofi


# Wallpapers & Colorscheme

* Pywal for colors
```sh
sudo pacman -S python-pywal
```

* Rotating wallpapers
```sh
sudo pacman -S feh
```

Resources:
* ~/.config/i3/scripts/wallpaper.sh
* https://github.com/dylanaraps/pywal
* https://wiki.archlinux.org/index.php/Feh

# Polybar
```sh
yay -S polybar
```

Resources:
* ~/.config/polybar/config
* https://wiki.archlinux.org/index.php/Polybar


# Suspend on close
```conf
#/etc/systemd/logind.conf
  [Login]
  HandlePowerKey=hibernate
  HandleLidSwitch=suspend
  HandleLidSwitchExternalPower=suspend
  HandleLidSwitchDocked=ignore
```

# Bluetooth

* Install and bluez
```sh
sudo pacman -S bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

* List and connect to device
```sh
bluetooth ctl
nmcli device wifi connect <ssid> password <password>
```


# Hibernation (Using swap file)

## Required kernel parameters
* `resume=UUID=<disk-UUID>`: Get the UUID of the disk on which swapfile resides.
```sh
sudo lsblk -o +UUID
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT UUID
nvme0n1     259:0    0 238.5G  0 disk
...
├─nvme0n1p6 259:6    0  61.7G  0 part /          dbfe6115-c82a-4106-9689-5f99e4176549
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
```

* `resume_offset=<swap_file_offset>`:

```
~❯ sudo filefrag -v /swapfile
Filesystem type is: ef53
File size of /swapfile is 2147483648 (524288 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:     397312..    397312:      1:
                              ^^^^^^
```

* Update `/etc/mkinitcpio.conf`
```
HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)
```

* Auto hibernate on 5% battery
```
# /etc/udev/rules.d/99-lowbat.rules

# Suspend the system when battery level drops to 5% or lower
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/usr/bin/systemctl hibernate"
```

## TODO

# Kawase blur for compton
* https://github.com/yshui/compton/issues/32

# Switch to i3 once i3-gaps merges into i3
# Can have multi polybar with i3-gaps once top gaps are released (i3-gaps version > 4.16.1)

# Light DM Greeter, might wanna skip for now to keep things lightweight
* https://github.com/NoiSek/Aether

# Notification Deamon
* https://wiki.archlinux.org/index.php/Dunst

# Power management related stuff like acpi events, hibernation

# Sound, Video codecs


