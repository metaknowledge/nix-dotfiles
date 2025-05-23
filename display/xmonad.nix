{ config, lib, pkgs, ... }:

{
  services = {
    upower.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkb.options = "ctrl:nocaps";
      desktopManager = {
        gnome.enable = false;
	plasma5.enable = false;
	xterm.enable = false;
      };
    };
    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
  };
  services.displayManager.ly.enable = true;


  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
