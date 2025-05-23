{config, lib, pkgs, ...}:
{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    desktopManager.xfce = {
      enable = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
    videoDrivers = ["nvidia"];
  };
  services.displayManager.ly.enable = true;
  programs.dconf.enable = true;
  services.picom.enable = true;
}
