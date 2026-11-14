{ pkgs, ... }:

{
  xdg.configFile."quickshell" = {
    source = ./quickshell-config; # Путь к вашим локальным файлам QML
    recursive = true;
  };
}
