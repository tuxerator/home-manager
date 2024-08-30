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


    flatpaks = {
      url = "github:gmodena/nix-flatpak";
    };


    nil-ls = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { nixpkgs
    , home-manager
    , neovim-nightly-overlay
    , flatpaks
    , nvimdots
    , nil-ls
    , ...
    }@inputs:

    let
      system = "x86_64-linux";
      overlays = [
        neovim-nightly-overlay.overlays.default
        (_: _: { nil = nil-ls.packages.${system}.nil; })
      ];

      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in
    {
      homeConfigurations."jakob@carrie2" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          flatpaks.homeManagerModules.nix-flatpak
          nvimdots.homeManagerModules.nvimdots
        ];


        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs.flake-inputs = inputs;
      };

      homeConfigurations."jakob@carrie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          flatpaks.homeManagerModules.nix-flatpak
          nvimdots.homeManagerModules.nvimdots
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
