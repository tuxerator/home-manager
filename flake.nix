{
  description = "Home Manager configuration of jakob";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nvimdots.url = "github:ayamir/nvimdots";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpaks = {
      url = "github:GermanBread/declarative-flatpak/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kidex.url = "path:/home/jakob/flakes/kidex";
    kidex.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    nil-ls = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , hyprland
    , anyrun
    , neovim-nightly-overlay
    , kidex
    , flatpaks
    , nvimdots
    , nil-ls
    , ironbar
    , ...
    }@inputs:

    let
      system = "x86_64-linux";
      overlays = [
        neovim-nightly-overlay.overlay
        (_: _: { nil = nil-ls.packages.${system}.nil; })
      ];

      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in
    {
      homeConfigurations."jakob@carrie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          hyprland.homeManagerModules.default
          anyrun.homeManagerModules.default
          kidex.homeManagerModules.default
          flatpaks.homeManagerModules.default
          nvimdots.nixosModules.nvimdots
          ironbar.homeManagerModules.default
        ];


        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs.flake-inputs = inputs;
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          neovim
        ];
      };
    };
}
