{ stdenv
, gsl
, ... }@args:

let source = builtins.fetchTarball {
             url = "https://webhome.phy.duke.edu/~rgb/General/dieharder/dieharder-3.31.1.tgz";
             sha256 = "1mr9nchi2gzqan1lzsinzqmiipn409ays4a7g81xa4fb6yhxpkwq";
          };
    src = "${source}/dieharder-3.31.1";
    patch = builtins.toFile "dieharder-patch" ''
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
 in stdenv.mkDerivation {
      name = "dieharder";
      inherit src;
      buildInputs = [ gsl ];
      patches = [ patch ];
      patchFlags = "-p0";
    }
