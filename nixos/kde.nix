{ ... }: {
   # Enable the X11 windowing system.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
}
