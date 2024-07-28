{ config, pkgs, lib, ... }:

{
  accounts.email.accounts = {
    uni = {
      address = "jakob.sanowski@uni-konstanz.de";
      userName = "jakob.sanowski";
      realName = "Jakob Sanowski";
      passwordCommand = "rbw get uni-konstanz.de";
      imap = {
        host = "imap.uni-konstanz.de";
        port = 143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "smtp.uni-konstanz.de";
        port = 587;
        tls.useStartTls = true;
      };
      thunderbird = {
        enable = true;
      };
      aerc = {
        enable = true;
      };
    };

    personal = {
      primary = true;
      address = "jakob.sanowski@sanbach.de";
      userName = "jakob.sanowski";
      realName = "Jakob Sanowski";
      passwordCommand = "rbw get ";
      imap = {
        host = "imap.strato.de";
        port = 993;
        tls = {
          enable = true;
        };
      };
      smtp = {
        host = "smtp.strato.de";
        port = 465;
        tls = {
          enable = true;
        };
      };
      thunderbird = {
        enable = true;
      };
      aerc = {
        enable = true;
      };
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.Default = {
      isDefault = true;
      withExternalGnupg = true;
    };
  };
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      viewer = {
        pager = "nvim -M";
      };
      compose = {
        editor = "nvim";
      };
    };
  };
}
