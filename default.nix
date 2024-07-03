{ stdenv }:
stdenv.mkDerivation {
  pname = "build";
  version = "0.0.1";

  src = [ ./. ];

  installPhase = ''
    install -D $src/build $out/bin/build
  '';
}
