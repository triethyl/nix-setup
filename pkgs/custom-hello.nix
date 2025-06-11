{
  lib,
  stdenv,
  runtimeShell,
}:
stdenv.mkDerivation {
  pname = "hello";
  version = "1.0";

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/hello << EOF
    #!${runtimeShell}
    echo "Hello, This is an example nix package!"
    EOF
    chmod +x $out/bin/hello
  '';

  meta = {
    description = "Example package";
    license = lib.licenses.free;
    mainProgram = "hello";
  };
}
