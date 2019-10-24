# Media manipulation tools

## `screencast.sh`

### Purpose

Capturate screencasts (see [this article](https://dev.to/courtjus/capturing-a-screencast-the-command-line-nerd-style-41g8) for details)

### Dependencies


* [FFmpeg](https://www.ffmpeg.org/), the swiss army knife of video
* [xdotool](https://www.semicomplete.com/projects/xdotool/), a small program allowing to manipulate windows, mouse, and keyboard in a X environment
* [dmenu](https://tools.suckless.org/dmenu/), a dynamic menu for X

### Usage

* Launch the script a first time
* Move your mouse to the top left corner of the zone you want to capture
* Press enter
* Move now to the bottom right corner
* Press enter, the capture starts immediatly
* Launch the script a second time and press enter to stop capturing
