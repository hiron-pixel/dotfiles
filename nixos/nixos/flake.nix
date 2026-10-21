{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    cskkSrc = {
      url = "github:naokiri/cskk/v3.2.1";
      flake = false;
    };
    fcitx5CskkSrc = {
      url = "github:fcitx/fcitx5-cskk/v1.2.0";
      flake = false;
    };
   arare = {
     url = "path:/home/lyshis/arare";
     inputs.nixpkgs.follows = "nixpkgs";
   };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, cskkSrc, fcitx5CskkSrc, arare, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
    };
  in {
    nixosConfigurations.nixos =
      nixpkgs.lib.nixosSystem {
        inherit system;

	specialArgs = {
          inherit pkgs-unstable cskkSrc fcitx5CskkSrc;
        };

	modules = [
	  ./configuration.nix
    {
        i18n.inputMethod.fcitx5.addons = [
            arare.packages.${system}.default
        ];
    }
	];
      };
  };
}




