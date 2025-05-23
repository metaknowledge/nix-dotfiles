{ config, pkgs, ... }:
let
  pinnedZoomPkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb.tar.gz";
      sha256 = "0ngw2shvl24swam5pzhcs9hvbwrgzsbcdlhpvzqc7nfk8lc28sp3";
  }) {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  pinnedZoom = pinnedZoomPkgs.zoom-us;

in
{
  imports =
    [
      ./hardware-configuration.nix
      # ./display/plasma.nix
      # ./display/i3.nix
      ./display/gnome.nix
      # ./display/xmonad.nix
      ./programs/neovim/default.nix
    ];
  #nix = {
  #  package = pkgs.nixFlakes;
  #};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_10;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.supportedFilesystems = [ "ntfs" ];  
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "openssl"
  ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    
    pinnedZoom
    polkit
    neovim

    unzip

    fastfetch
    xwayland
    #SDL2
    # Trying to get it work
    xorg.libXrandr
    xorg.xeyes
    xorg.xrandr
    wayland-utils
    xwayland-run
    libdecor
    #SDL_gpu
    weston
    wlr-protocols
    lhasa
    # elan
    # lean4
    i3status
    nnn
    lxappearance
    ly
    rofi

    gcc
    harlequin
    gdb
    
    nix-ld
    envfs
    xorg.libX11
    libGL
    wget
    davinci-resolve
    # sqsh
    dbeaver-bin
    valgrind-light

    #gnome apps
    gnome-boxes

    kvmtool
    libvirt
    
    devhelp
    sushi
    gnome-screenshot
    dconf-editor
    gnome-podcasts
    gnome-solanum
    enter-tex

    # music
    # cider-2 # need to buy this ~$3.5
    audacity
    # fl-studio

    # blender

    impression
    # khronos
    # libcaca

    # java
    jdk
    jdk17
    google-java-format
    dotnet-sdk_8
    maven


    # minecraft
    mangohud
    jprofiler
    (prismlauncher.override {
      jdks = builtins.attrValues {
	inherit (pkgs) 
	  jdk8
	  jdk11
	  jdk17
	  jdk;
      };
      additionalPrograms = builtins.attrValues { inherit (pkgs) mangohud jprofiler; };
    })

    # school
    obsidian
    # zotero
    pdftk
    zathura
    libreoffice

    xdg-desktop-portal
    lightdm
    anki
    # slack
    discord
    hollywood
    tty-clock

    #texliveMedium
    texliveFull
    # texlive.combined.scheme-full
    texlivePackages.pstricks
    texlivePackages.pspicture
    texlivePackages.psfrag
    texlivePackages.pst-plot
    texlivePackages.pst-node
    texlivePackages.pstricks-add
    #
    # game dev
    godot_4
    unityhub
    alvr
    wine
    wine-wayland
    # bambu-studio


    # gaming

    # bottles

    #other
    qrtool
    # yarr # yet another rss reader
    dbus
    # python312Packages.pip


    yt-dlp
    kitty
    strace
    sl
    lshw
    pandoc
    ntfs3g
    exfat
    python3
    git
    # wayback_machine_downloader
    rustup
    rpi-imager
    fish
    obs-studio
    tmux
    cowsay
    fortune
    lolcat
    # gimp
    gimp-with-plugins
    gimpPlugins.gmic
    # gmic # image processing for gimp
    vscode
    rsync
    smu
    uutils-coreutils-noprefix
    gnused
    gnumake
    entr
    docker
    sqlcmd
    speedtest-cli
    inkscape
    zip
    postgresql
    xorg.xhost
    dconf
    openssl
    openssl.dev
    pkg-config
    sshpass



    #gis
    qgis-ltr
    (qgis.override {
      extraPythonPackages = ps:
      	with ps; [
	  numpy
	  geopandas
	  rasterio
	];
    })
  ];
  virtualisation.docker.enable = true;
  # will compile from source?
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;


  environment.extraOutputsToInstall = [ "dev" ];
  # environment.variables.C_INCLUDE_PATH = "${nixpkgs.expat.dev}/include";

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];






  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;
  # from no-boiler-plate
  # https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md
  #system.autoUpgrade = {
  #enable = true;
  #flake = inputs.self.outPath;
  #flags = [
  #  "--update-input"
  #  "nixpkgs"
  #  "-L" 
  #];
  #dates = "09:00";
  #randomizedDelaySec = "45min";
  #};


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };




  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Nvidia graphics 
  hardware.graphics.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
   # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  #hardware.nvidia.prime = {
  #  offload = {
  #  	enable = true;
  #      enableOffloadCmd = true;
  #  };
  #  # sync.enable = true;
  #  intelBusId = "PCI:0:2:0";
  #  nvidiaBusId = "PCI:1:0:0";
  #};
  # hardware.nvidia.forceFullCompositionPipeline = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  programs.dconf.enable = true;


  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.apollo = {
    isNormalUser = true;
    description = "Apollo";
    extraGroups = [ "docker" "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [
    	firefox-bin

    ];

  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged 
    # programs here, NOT in environment.systemPackages
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    pango
    pipewire
    stdenv.cc.cc
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
    #SDL2
    #SDL2.dev
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
