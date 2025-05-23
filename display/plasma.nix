{config, lib, pkgs, ...}:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.dconf.enable = true;
  # services.displayManager.defaultSession = "plasma";
}
