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
apk add bash git vim tmux htop 
doas mv /usr/bin/vi /usr/bin/vi.bak
doas ln -s /usr/bin/vim /usr/bin/vi
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
- Because many GUI applications are built on glibc (which Alpine has forgone in favor of musl), installing natively may prove difficult or impossible.
-  For instance, using Spotify web player depends on Widevine DRM browser plugin, which depends on glibc: https://wiki.postmarketos.org/wiki/Widevine
-  Flatpack provides apps bundled with their dependencies and runs them in a sandboxed environment: https://docs.flatpak.org/en/latest/introduction.html
```
sudo apk add flatpak
flatpack install flathub com.spotify.Client
flatpak run com.spotify.Client --username=<user> --password=<pass>
flatpak install flathub com.visualstudio.code
flatpak run com.visualstudio.code
```