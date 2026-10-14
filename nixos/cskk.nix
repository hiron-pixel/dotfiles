{ pkgs, cskkSrc, fcitx5CskkSrc, ... }: 
let
  libcskk = pkgs.rustPlatform.buildRustPackage {
    pname = "cskk";
    version = "3.2.1";
    src = cskkSrc;
    cargoLock.lockFile = "${cskkSrc}/Cargo.lock";
 
    nativeBuildInputs = with pkgs; [
      cargo-c
      rust-cbindgen
      pkg-config
    ];
    buildInputs = [ pkgs.libxkbcommon ];
 
    buildPhase = ''
      runHook prebuild
      cargo cbuild --release --locked --offline
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cargo cinstall --release --locked --offline \
        --prefix="$out" --libdir=lib
      runHook postInstall
    '';

    doCheck = false;
  };

  cskkAddon = pkgs.stdenv.mkDerivation {
    pname = "fcitx5-cskk";
    version = "1.2.0";
    src = fcitx5CskkSrc;

    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      kdePackages.extra-cmake-modules
      pkg-config
      gettext
    ];
    buildInputs = [
      pkgs.fcitx5
      libcskk
      pkgs.libsForQt5.qtbase
      pkgs.libsForQt5.fcitx5-qt
    ];

    cmakeFlags = [
      "-DENABLE_QT6=OFF"
      "-DSKK_DICT_DEFAULT_PATH=${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L"
    ];

    postPatch = ''
      sed -i '1i#include <fcitx-utils/standardpath.h>' src/cskk.cpp
    '';

    passthru.extraLibraries = [ libcskk ];
    dontWrapQtApps = true;
  };
in
  {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [ cskkAddon ];
    };
  }
