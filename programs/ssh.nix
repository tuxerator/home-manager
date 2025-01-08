{ config, lib, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      PasswordAuthentication no
      IdentitiesOnly yes
    '';
    matchBlocks = {
      "192.168.*.*" = {
        extraOptions = {
          HostKeyAlgorithms = "+ssh-rsa";
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
        };
      };
    };
  };
}
