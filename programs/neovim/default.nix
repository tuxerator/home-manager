{ pkgs, flake-inputs, ... }:
let

  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]));
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    coc.enable = false;

    plugins = [
      treesitterWithGrammars
    ];

    extraPackages = with pkgs; [
      libgcc
      gnumake
      ninja
      cargo
      pkg-config
      clang
      gcc
      sqlite
      doq
      ripgrep
      bash
      nixpkgs-fmt
      nil
      lazygit
      tree-sitter
      nodejs_22
      jdk
      rust-analyzer
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./lazy;
    recursive = true;
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}
