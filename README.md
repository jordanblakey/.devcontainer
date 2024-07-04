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

### Install basics

``` sh
apk add git python3
```

### Install docker
- https://wiki.alpinelinux.org/wiki/Docker

``` sh
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
```