{ pkgs }:

assert pkgs.lib.assertMsg (pkgs.zed-editor.version == "1.22.0")
  "This experimental surrounding-text patch is for Zed 1.22.0 only.";

pkgs.zed-editor.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [ ./zed-surrounding-text.patch ];
})
