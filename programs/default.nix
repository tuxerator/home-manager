{ config, pkgs, ... }:

{
  imports = [
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    helvum
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.sftpman = {
    enable = true;
    mounts = {
      "pixel7" = {
        host = "192.168.178.28";
        mountPoint = "/sdcard";
        port = 1739;
        sshKey = "/home/jakob/.config/kdeconnect/privateKey.pem";
        user = "kdeconnect";
      };
    };
  };
}
