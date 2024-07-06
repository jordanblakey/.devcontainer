# Alpine Linux Desktop Install Notes

- https://wiki.alpinelinux.org/wiki/Create_a_Bootable_Device

## From installation media
```sh
setup-keymap
setup-alpine
setup-xorg-base
setup-desktop # setup xfce
reboot
```
## From disk OS

### OS Tweaks
```sh
# Map capslock as a 2nd escape key
doas apk add setxkbmap
setxkbmap -option caps:escape # Set this as a command in startup
# Fix keyboard layout in light-dm
doas vi /etc/lightdm/lightdm.conf # Under [:Seat], set display_startup_script=/usr/bin/setxkbmap us colemak
# Enable Lock Screen and Suspend
doas apk add xfce4-screensaver 
```

### Install basics
- https://wiki.alpinelinux.org/wiki/Change_default_shell

```sh
apk add bash git vim curl tmux htop 
doas mv /usr/bin/vi /usr/bin/vi.bak
doas ln -s /usr/bin/vim /usr/bin/vi

printf "set showmatch\nset incsearch\nset hlsearch\nset tabstop=2\n" >> ~/.vimrc
printf "set expandtab\nset autoindent\nfiletype plugin indent on\n" >> ~/.vimrc
printf "set number\nset relativenumber\nset cursorline\n" >> ~/.vimrc
echo "set -g mouse on" >> ~/.tmux.conf
```

### Setup Python
```sh
apk add python3
python3 -m venv ~/.venv
echo "alias venv=\"source ~/.venv/bin/activate\"" >> ~/.bashrc
```

### Install docker
- https://wiki.alpinelinux.org/wiki/Docker

```sh
apk add docker docker-cli-compose
apk addgroup $USER docker
rc-update add docker default
service docker start
```
### Enable audio

- https://wiki.alpinelinux.org/wiki/ALSA
- https://wiki.alpinelinux.org/wiki/PulseAudio

```
apk add alsa-utils alsaconf
addgroup $USER audio
doas addgroup $USER audio
doas addgroup root audio
rc-service alsa start
alsamixer # Unmute the master channel
rc-update add alsa
apk add pulseaudio pulseaudio-alsa 
apk add xfce4-pulseaudio-plugin pavucontrol # Launcher > panels > add pulseaudio panel
```

### Install desktop apps
- tl;dr Flatpak apps are glitchy on Alpine and have limitations around creating unsandboxed processes (say for doas and docker)
```
# Install a Spotify daemon
apk add spotifyd spotifyd-openrc
apk add rustup
rustup-init
mkdir -p ~/.config/spotifyd && vi ~/.config/spotifyd/spotifyd.conf
# Set keys username, password, backend, device_type: https://docs.spotifyd.rs/config/File.html

# Install a Spotify CLI
doas apk add build-base openssl-dev libssl3 libcrypto3 
cargo install spotify-tui # resolve deps as needed

# Run them together
alias spotify="if pgrep -x "spotifyd" > /dev/null; then echo \"spotifyd is already running\"; else echo \"starting spotifyd\" && spotifyd; fi; spt"
# There is a spotifyd-openrc package in apk, but I couldn't figure out which configuration files it used
```