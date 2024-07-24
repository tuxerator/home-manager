{ config, lib, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "local-net" = {
        hostname = "192.168.*.*";
        extraOptions = {
          HostKeyAlgorithms = "+ssh-rsa";
        };
      };
    };
  };
}
