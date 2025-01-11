{ inputs, pkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    optimise.automatic = true;
    package = pkgs.nixVersions.latest;

    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
}
