{ pkgs }:

# https://github.com/swaywm/sway/issues/9191
# Apply to the compositor itself, before Nixpkgs adds its session wrapper.
pkgs.sway.override {
  sway-unwrapped = pkgs.sway-unwrapped.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace sway/input/text_input.c \
        --replace-fail 'input->active_features & WLR_TEXT_INPUT_V3_FEATURE_SURROUNDING_TEXT' 'input->current.features & WLR_TEXT_INPUT_V3_FEATURE_SURROUNDING_TEXT' \
        --replace-fail 'input->active_features & WLR_TEXT_INPUT_V3_FEATURE_CONTENT_TYPE' 'input->current.features & WLR_TEXT_INPUT_V3_FEATURE_CONTENT_TYPE'
    '';
  });
}
