{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "loginctl lock-session";
      }
      {
        event = "lock";
        command =
          "${pkgs.sysvtools}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
      }
    ];

    timeouts = [
      {
        timeout = 600;
        command = "loginctl lock-session";
      }

      {
        timeout = 700;
        command = "systemctl suspend-then-hibernate";
      }
    ];
  };
}
