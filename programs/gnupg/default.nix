{ pkgs, ... }: {
  programs.gpg = {
    enable = true;
    publicKeys = [{ source = ./public-key.txt; }];
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    sshKeys = [ "DCAF94191C52BA7C402D2BDBA6F51BF94613B6E5" ];
  };
}
