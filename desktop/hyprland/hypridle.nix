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
            on-timeout = ''
              if [ "$(loginctl show-session self -P State)" = "active" ]; then loginctl lock-session; fi'';
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
          PartOf = "lock.target";
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
