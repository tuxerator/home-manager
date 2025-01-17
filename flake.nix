{
  description = "Home Manager configuration of jakob";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-hyprXPrimary = {
      url = "github:tuxerator/hyprXPrimary";
      inputs.hyprland.follows = "hyprland";
    };

    neovim-nightly-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/neovim-nightly-overlay";
    };

    flatpaks = { url = "github:gmodena/nix-flatpak"; };

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, neovim-nightly-overlay, flatpaks, stylix
    , nur, ... }@inputs:

    let
      system = "x86_64-linux";
      overlays = [
        #    neovim-nightly-overlay.overlays.default
        #    (_: _: { nil = nil-ls.packages.${system}.nil; })
        nur.overlays.default
      ];

      pkgs = import nixpkgs { inherit system overlays; };
    in {
      homeConfigurations."jakob@carrie2" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./carrie.nix
          flatpaks.homeManagerModules.nix-flatpak
          stylix.homeManagerModules.stylix
        ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs.flake-inputs = inputs;
        };

      homeConfigurations."jakob@thickPad" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home.nix
            ./thickPad.nix
            flatpaks.homeManagerModules.nix-flatpak
            stylix.homeManagerModules.stylix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs.flake-inputs = inputs;
        };
      homeConfigurations."jakob@carrie" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix flatpaks.homeManagerModules.nix-flatpak ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs.flake-inputs = inputs;
        };

      devShells.${system}.default =
        pkgs.mkShell { packages = with pkgs; [ neovim ]; };
    };
}
