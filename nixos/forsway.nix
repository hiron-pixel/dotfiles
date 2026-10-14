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
