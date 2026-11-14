{ config, pkgs, unstable, ... }:

{
  #---------USER-DATA------
  home.username = "sm1le";
  home.homeDirectory = "/home/sm1le";

  #------HOME-MANAGER-SETTINGS--------
  programs.home-manager.enable = true;

  #-------USER-INSTALLATIONS--------
  home.packages =
  #=====STABLE===== 
  (with pkgs; [
    cmatrix
    cava
    flatpak
    yazi
    chromium
  ]) 
  ++
  #=====UNSTABLE=====
  (with unstable; [
	quickshell
	rofi
	awww
    claude-code
    wordcraft
    gridcraft
    viber
    telegram-desktop
    discord
    unityhub
    vscode
    spotify
    obsidian
  ]);  

  #-------IMPORTS-MODULES----------
  imports = [
     ./home-modules/git.nix
     ./home-modules/alacritty.nix
     ./home-modules/hyprland.nix
     ./home-modules/quickshell.nix
   ];

  #-------STATE-VERSION--------
  #!!!!!!!DONT-TOUCH!!!!!!!!!
    home.stateVersion = "26.05";
}
