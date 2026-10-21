{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    waybar
    wl-clipboard
    mako
    fuzzel
    wezterm
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
    };
  };
   programs.sway = {
     enable = true;
     package = import ./sway-surrounding-text.nix { inherit pkgs; };
     wrapperFeatures.gtk = true;
   };

  programs = {
    thunar.enable = true;
    xfconf.enable = true;
  };

  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
