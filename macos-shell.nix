with import <nixpkgs> { };

stdenv.mkDerivation {
  name = "macos-dev-environment";

  buildInputs = [
    pkg-config
    gcc
    openssl
    zlib
    gtk4
    libadwaita
  ];
}
