{ config, pkgs, lib, ... }:

let
  pendingMonoHWNF = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "pending-mono-hwnf";
    version = "0.0.3";

    src = pkgs.fetchurl {
      url = "https://github.com/yuru7/pending-mono/releases/download/v${version}/PendingMonoHWNF_v${version}.zip";

      # 最初のrebuildで正しいhashが表示される
      hash = "sha256-PKAnTjBnM2tlImZdDXR1/m9B8H0h4BbojCqwRKqyVeU=";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    dontUnpack = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/fonts/truetype
      unzip -j $src '*.ttf' -d $out/share/fonts/truetype

      runHook postInstall
    '';

    meta = {
      description = "Commit Mono and BIZ UDGothic composite font";
      homepage = "https://github.com/yuru7/pending-mono";
      license = lib.licenses.ofl;
      platforms = lib.platforms.all;
    };
  };
in
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.commit-mono
      pendingMonoHWNF
      biz-ud-gothic
      ipaexfont
    ];

    fontconfig.defaultFonts = {
      sansSerif = [
        "BIZ UDPGothic"
	"IPAexMincho"
        "Noto Sans CJK JP" # 欠字用
      ];

      monospace = [
        "Pending Mono HWNF"
        "Noto Sans Mono CJK JP" # 欠字用
      ];

      emoji = [
        "Noto Color Emoji"
      ];
    };
  };

}
