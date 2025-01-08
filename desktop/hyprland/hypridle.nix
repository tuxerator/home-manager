{ pkgs, ... }:
{
  options = { };
  config = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session; sleep 1";
          after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "${pkgs.sysvtools}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 700;
            on-timeout = "systemctl suspend-then-hibernate";
            on-resume = "eww close bar; eww open bar";
          }
        ];
      };
    };
  };
}
