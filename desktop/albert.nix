{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    albert
  ];

  systemd.user.services.albert = {
    Unit = {
      Description = "Albert daemon";
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "albert" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.albert}/bin/albert -p ${pkgs.albert}/lib/albert
      ''}";
      Restart = "always";
    };

    Install = { WantedBy = [ "default.target" ]; };
  };

}
