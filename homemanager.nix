{ config, pkgs, unstable, ... }:

{
  # Базовые данные пользователя
  home.username = "sm1le";
  home.homeDirectory = "/home/sm1le";

  # Разрешаем Home Manager управлять самим собой
  programs.home-manager.enable = true;

  home.packages = (with pkgs; [
    cmatrix
    cava
    flatpak
  ]) ++ (with unstable; [
    #bonsai
  ]);

  imports = [
     ./home-modules/git.nix
   ];

  # Версия релиза, с которого вы начали (не меняйте её при будущих обновлениях)
    home.stateVersion = "26.05";
}
