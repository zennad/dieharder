{
  description = "Dieharder";
  inputs =
    {
      nixpkgs.url = "nixpkgs";
      dieharder.url = github:zennad/dieharder/dieharder-source;
      dieharder.flake = false;
    };
  outputs = { self, nixpkgs, dieharder }: {
    packages.x86_64-linux.dieharder =
      with import nixpkgs { system = "x86_64-linux"; };
      let patch = builtins.toFile "dieharder-patch" ''
                       diff --git a/include/dieharder/libdieharder.h b/include/dieharder/libdieharder.h
                       index 2138ebf..d98b758 100644
                       --- ./include/dieharder/libdieharder.h
                       +++ ./include/dieharder/libdieharder.h
                       @@ -17,6 +17,7 @@

                        /* This turns on uint macro in c99 */
                        #define __USE_MISC 1
                       +#include <stdint.h>
                        #include <sys/types.h>
                        #include <sys/stat.h>
                        #include <unistd.h>
                    '';
      in stdenv.mkDerivation
        {
          name = "dieharder";
          src = dieharder;
          buildInputs = [ gsl ];
          patches = [ patch ];
          patchFlags = "-p0";
        };
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.dieharder;
  };
}
