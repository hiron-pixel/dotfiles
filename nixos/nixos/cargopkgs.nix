{ pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
        (rustPlatform.buildRustPackage rec {
            pname = "Raijin";
            version = "0.2.0";

            src = fetchCrate {
                inherit pname version;
                hash = "sha256-BP4NQgeGWOfxYIKDdrcO8rLiwwkL0J9ADA4XgTAtFcw=";
            };

            cargoHash = "sha256-MEV5lyUANGAxcy6kKvvek7pYjTHkGE2kBtCsQa53AZg=";
         })
    ];
}
