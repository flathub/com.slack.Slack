# Slack

Slack is a messaging app for business that connects people to the information they need.

This repo hosts the flatpak wrapper for [Slack](https://slack.com/), available at [Flathub](https://flathub.org/apps/details/com.slack.Slack).

```sh
flatpak install flathub com.slack.Slack
flatpak run com.slack.Slack
```

### Wayland

This package enables the flags to run on Wayland, however it is opt-in. To opt-in run:

```sh
flatpak override --user --socket=wayland com.slack.Slack
```

To opt-out do the same with `--nosocket=wayland`.
