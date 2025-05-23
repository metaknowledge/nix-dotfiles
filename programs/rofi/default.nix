{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    # terminal = "${pkgs.kitty}/bin/alacritty";
    # theme = ./theme.rafi;
  };
}
