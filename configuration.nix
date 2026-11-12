# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, pkgs, unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # ----------SYSTEMD-BOOT-----------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;#ограничеваем меню загрузки до 5 элементов
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; # Удалит конфигурации старше недели
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #--------------NETWORKING-----------
  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true; #Enable networking

  #-------------TIMEZONE--------------
  time.timeZone = "Europe/Kyiv";

  #-------------LOCALIZATION---------
  i18n.defaultLocale = "ru_UA.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_ALL = "ru_UA.UTF-8";
    LC_CTYPE = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MESSAGES = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };
  
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "uk_UA.UTF-8/UTF-8"
    "ru_UA.UTF-8/UTF-8"
  ];
  
  #----------UNITY-LIBS-------------
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    ncurses
    zlib
    glibc
    openssl
    icu
  ];

  #--------X11-WINDOW-SYSTEM--------
  services.xserver.enable = true;
  services.xserver.xkb = {
      layout = "us";
      variant = "";
   };# Configure keymap in X11
    
  #---------KDE-PLASMA------------
  services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
    enable = true;
    extraPackages = [ pkgs.sddm-astronaut ]; 
    theme = "sddm-astronaut-theme"; 
  };

  #------------PRINTER-------------
  services.printing.enable = true;

  #------------AUDIO---------------
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # If you want to use JACK applications, uncomment this
  };

  #----------TOUCHPAD--------------
  services.libinput.enable = true;

  #---------ZSH-SETTINGS-----------
  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    interactiveShellInit = "fastfetch";
  };

  #---------USER-SETTINGS---------
  users.users."sm1le" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sm1le";
    extraGroups = [ "networkmanager" "wheel" "docker"];
  };    
   

  #--------INSTALLATIONS----------
  programs.firefox.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

  environment.systemPackages =
  #==STABLE-BRANCH-PKGS==
  (with pkgs; [
    vim
    micro
    python3
    wget
    curl
    git
    git-lfs
    fastfetch
    bat
    sddm-astronaut
    unzip
    unrar
    xdg-user-dirs
    btop
  ])
  #==UNSTABLE-BRANCH-PKGS==
  ++
  (with unstable; [
  	#program-name
  ]);

  programs.steam = { enable = true; package = unstable.steam; };

  virtualisation.docker.enable = true;

  # --------------SUID--------------
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #--------------OPEN-SSH------------
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  #-------------FIREWALL------------
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #------IF-YOU-DELETE-THIS-FILE------ 
  # system.copySystemConfiguration = true;

  #-----------STATE-VERSION---------
  #!!!!!!!!!!!DONT-TOUCH!!!!!!!!!!!
  system.stateVersion = "26.05";

}
