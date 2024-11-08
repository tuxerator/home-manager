{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = false;
    history = {
      ignoreDups = true;
    };
    shellAliases = {
      cd = "z";
      ls = "eza";
      ll = "eza -lha";
    };
    sessionVariables = {
      EZA_ICONS_AUTO = true;
    };
    # envExtra = ''
    #   source /etc/profile.d/nix.sh
    # '';
    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz"
        "romkatv/powerlevel10k"
        "zsh-users/zsh-completions"
        "belak/zsh-utils path:completion"
        "davidde/git"
        "ohmyzsh/ohmyzsh path:plugins/direnv"
        "3v1n0/zsh-bash-completions-fallback kind:defer"
        "chisui/zsh-nix-shell kind:defer"
        "peterhurford/up.zsh kind:defer"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "zsh-users/zsh-autosuggestions kind:defer"
        "zsh-users/zsh-history-substring-search kind:defer"
      ];
    };
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down

      [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

      eval "$(zoxide init zsh)"
    '';
  };

  home.file.".config/zsh/.p10k.zsh" = {
    source = ./.p10k.zsh;
  };

  home.packages = with pkgs; [
    zoxide
    eza
    tldr
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # programs.yazi = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };
}
