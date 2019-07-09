This repo contains a working version of the slack x86-64 app packaged as a flatpak.

The app builds on uses the freedesktop.org runtime and the
[electron-flatpak-base-app](https://github.com/endlessm/electron-flatpak-base-app).
You will need both to build the app; they are available for install on Flathub.

This app is sandboxed for higher security. If you absolutely need `$HOME` access for your Slack on your system, please use either 
```sh
$ flatpak run --filesystem=home com.slack.Slack
```
to run Slack with temporary home access, or
```sh
$ sudo flatpak override --filesystem=home:ro com.slack.Slack
```
to permanently set `~/` access for Slack.