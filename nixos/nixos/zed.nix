{ pkgs, pkgs-unstable, ... }: 

{
  environment.systemPackages = [
    (import ./zed-surrounding-text.nix { pkgs = pkgs-unstable; })
  ];
}
