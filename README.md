This repo contains a working version of the slack x86-64 app packaged as a flatpak.

The app builds on uses the freedesktop.org runtime and the
[electron-flatpak-base-app](https://github.com/endlessm/electron-flatpak-base-app).
You will need both to build the app; they are available for install on Flathub.

## Accessing `$HOME`

This app is sandboxed for higher security. If you absolutely need `$HOME` access for your Slack on your system, please use either 
```sh
$ flatpak run --filesystem=home com.slack.Slack
```
to run Slack with temporary home access, or
```sh
$ sudo flatpak override --filesystem=home com.slack.Slack
```
to permanently set `~/` access for Slack.

## I'm having incorrect timezone on messages

The timezone should be automatically detected, but seems to not be for some users. You can use 
```
$ sudo flatpak override --env=TZ=[TIMEZONE] com.slack.Slack
```
to manually set the timezone for your Slack installation, where `[TIMEZONE]` is the [TZ database name](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). 

For example `$ sudo flatpak override --env=TZ=Australia/Perth com.slack.Slack`.
