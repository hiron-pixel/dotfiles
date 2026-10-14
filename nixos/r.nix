{ pkgs, ... }:

# let
#   knitrNew = pkgs.rPackages.knitr.overrideAttrs (old: rec {
#     version = "1.52";
# 
#     src = pkgs.fetchurl {
#       url = "https://cran.r-project.org/src/contrib/knitr_${version}.tar.gz";
#       hash = "sha256-vdZqAt+6CKTGRLOKauCPa6kVwW1rarahiOwZPDWQX/I=";
#     };
#   });
# in
let
  rPkgs = with pkgs.rPackages; [
    ragg
    tidyverse
    tinytable
    ggplot2
    dplyr
    knitr
    kableExtra
    units
    quarto
    bslib
    fs
    sass
    latex2exp
  ]; 
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-41.10.7"
  ];
  nixpkgs.overlays = [
    (final: prev: {
      rPackages = prev.rPackages.override {
        overrides = {
          knitr = prev.rPackages.knitr.overrideAttrs (old: {
            version = "1.52";
            name = "r-knitr-1.52";

            src = prev.fetchurl {
              url = "https://cran.r-project.org/src/contrib/knitr_1.52.tar.gz";
              hash = "sha256-vdZqAt+6CKTGRLOKauCPa6kVwW1rarahiOwZPDWQX/I=";
            };
          });
        };
      };
    })
  ];
  environment.systemPackages = with pkgs; [
      (rstudioWrapper.override {
        packages = rPkgs;
      })

      (rWrapper.override {
        packages = rPkgs;
      })
   ];
}
