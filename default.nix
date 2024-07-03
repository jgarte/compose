{ stdenv }:
stdenv.mkDerivation {
  pname = "hello";
  version = "0.0.1";

  src = [ ./. ];

  installPhase = ''
    install -D $src/hello.sh $out/bin/hello
  '';
}
