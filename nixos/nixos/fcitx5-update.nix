{ ... }:

{
  # Keep the host's existing Fcitx5 addons and NixOS service configuration.
  nixpkgs.overlays = [
    (final: prev: {
      fcitx5 = if prev.lib.versionAtLeast prev.fcitx5.version "5.1.23" then
        prev.fcitx5
      else prev.fcitx5.overrideAttrs (old: {
        version = "5.1.23";
        src = prev.fetchFromGitHub {
          owner = "fcitx";
          repo = "fcitx5";
          rev = "5.1.23";
          hash = "sha256-5RDLAUqIOQiDt8CsMFXof8Y7F79Reyhpv7tcW57uw+Y=";
          fetchSubmodules = true;
        };
        buildInputs = (old.buildInputs or []) ++ [
          prev.kdePackages.plasma-wayland-protocols
          prev.librsvg
        ];
      });
    })
  ];
}
