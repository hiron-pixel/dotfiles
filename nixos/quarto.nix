{ pkgs, ... }:

let
  patchedQuarto = pkgs.quarto.overrideAttrs (oldAttrs: {
    postPatch = (oldAttrs.postPatch or "") + ''
      substituteInPlace bin/quarto.js \
        --replace-fail "syntax-highlighting" "highlight-style"
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    patchedQuarto
  ];
}
