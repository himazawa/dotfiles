{ config, pkgs, ... }:

{
  home.file.".config/kitty/kitty.conf".text = ''

#zshell
shell zsh

# Remove close window confirm
confirm_os_window_close 0

# Font config
font_family      Fira Code
bold_font        Fira Code
italic_font      Fira Code
bold_italic_font Fira Code

background_opacity 0.5
dynamic_background_opacity yes
include /home/himazawa/.cache/wal/colors-kitty.conf

  '';
}
