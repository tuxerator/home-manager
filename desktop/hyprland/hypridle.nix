{ pkgs, ... }: {
  options = { };
  config = let
  in {
    services.hypridle = {
      enable = true;
      settings = {
        general = { ignore_dbus_inhibit = false; };

        listener = [
          {
            timeout = 30;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 40;
            on-timeout = "systemctl suspend-then-hibernate";
            on-resume = "eww close bar; eww open bar";
          }
        ];
      };
    };

    systemd.user.services = {
      hyprlock = {
        Unit = {
          Description = "Lock screen daemon";
          OnSucess = "unlock.target";
          PartOf = "lock.target";
          After = "lock.target";
        };

        Install = { WantedBy = [ "lock.target" ]; };
        Service = {
          ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
          Type = "forking";
          Restart = "on-failure";
        };
      };
    };
  };
}
