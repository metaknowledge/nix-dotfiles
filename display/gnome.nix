{config, lib, pkgs, ...}:
{
  services.xserver = {
      enable = true;
      autorun = true;
      desktopManager.gnome.enable = true;
  };
  services.displayManager.ly.enable = true;
  security.polkit.enable = true;
}
