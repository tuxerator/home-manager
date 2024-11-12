{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.flatpak;

  flatpakPackage = { name, config, ... }:
    let
      cfg = config;
    in
    {
      options = {
        package = mkOption {
          type = types.str;
        };
        autostart = mkOption {
          type = types.submodule {
            options = {
              enable = mkEnableOption "autostart";

              command = mkOption {
                type = types.str;
              };

              args = mkOption {
                type = types.listOf types.string;
                default = [ ];
              };
            };
          };
        };
      };

      config = {
        autostart.command = lib.mkDefault "flatpak run ${cfg.package} ${lib.strings.concatStringsSep " " cfg.autostart.args}";
        package = lib.mkDefault name;
      };

    };

  autostartFlatpaks = attrsets.filterAttrs (_: v: v.autostart.enable) cfg.packages;

  autostartServices = attrsets.mapAttrs'
    (name: value: attrsets.nameValuePair name
      {
        Unit = {
          Description = "${value.package} autostart daemon";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.writeShellScript "start-${value.package}" ''
              #!/run/current-system/sw/bin/bash
              ${value.autostart.command}
          ''}";
          Restart = "always";
        };

        Install = { WantedBy = [ "graphical-session.target" ]; };
      }
    )
    autostartFlatpaks;
in

{
  options = {
    flatpak.packages = mkOption {
      type = types.attrsOf
        (types.submodule flatpakPackage);
      default = { };
    };
  };

  config = mkIf (cfg.packages != { })
    {
      services.flatpak = {
        enable = true;
        update.auto = {
          enable = true;
          onCalendar = "weekly";
        };
        packages = builtins.attrNames cfg.packages ++ [ "com.github.tchx84.Flatseal" ];
      };
      systemd.user.services = autostartServices;
    };
}
