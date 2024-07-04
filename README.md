Notes for instaling Alpine Linux as Desktop OS

```sh
# From installation media ##################
setup-alpine
setup-xorg-base
setup-desktop # setup xfce

# From disk OS #############################

# Install basics
apk add git python3

# Install docker
apk add docker docker-cli-compose
apk addgroup $USER docker
rc-update add docker default
service docker start

# Enable audio
apk add alsa-utils alsaconf
addgroup $USER audio
doas addgroup $USER audio
doas addgroup root audio
rc-service alsa start
rc-update add alsa
apk add pulseaudio pulseaudio-alsa 
apk add xfce4-pulseaudio-plugin pavucontrol # Launcher > panels > add pulseaudio panel

# Install desktop apps
sudo apk add flatpak
flatpack install flathub com.spotify.Client
```