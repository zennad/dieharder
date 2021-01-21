let nixpkgs = import <nixpkgs> {};
    callPackage = nixpkgs.callPackage;
    pkgs = {
             dieharder = callPackage ./dieharder.nix { };
           };
 in pkgs
