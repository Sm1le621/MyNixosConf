{ pkgs, ... }: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    # Отключаем системный вайндредер, если ставим через HM, либо оставляем по умолчанию
    systemd.enable = true; 
    
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [
        "quickshell" # Запуск панели Quickshell
      ];

      input = {
        kb_layout = "us,ru,ua";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(cba6f7ee) rgba(89b4fafa) 45deg";
        "col.inactive_border" = "rgba(585b70aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      # Простые горячие клавиши
      "$mod" = "SUPER";
      bind = [
        "$mod, T, exec, alacritty" # Открыть ваш любимый терминал
        "$mod, Q, killactive,"      # Закрыть активное окно
        "$mod, M, exit,"            # Выйти из сессии Hyprland
        "$mod, Space, exec, rofi -show drun" # Меню приложений

        # Перемещение фокуса
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ];
    };
  };
}
