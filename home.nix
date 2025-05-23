{ config, pkgs, ... }:

{
  home.username = "apollo";
  home.homeDirectory = "/home/apollo";
  
  programs.git = {
    enable = true;
    userName = "Daniel Hughes";
    userEmail = "danielh5@uw.edu";
  };
  home.stateVersion = "24.11";
  
  programs.home-manager.enable = true;
  
  imports = [
    # ./programs/xmonad/default.nix
    # ./programs/rofi/default.nix
    # ./services/dunst/default.nix
    # ./services/picom/default.nix
    # ./services/udiskie/default.nix
  ];



}
