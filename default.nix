let nixpkgs = import <nixpkgs> {};
    callPackage = nixpkgs.callPackage;
    mkDerivation = nixpkgs.stdenv.mkDerivation;
    pkgs = {
             dieharder = callPackage ./dieharder.nix { inherit mkDerivation; };
           };
 in pkgs
