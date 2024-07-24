{ config, lib, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
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
