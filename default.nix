with import <nixpkgs> { };

stdenv.mkDerivation {
  name = "dev-environment";

  buildInputs = [
    pkg-config
    gcc
    openssl
    zlib
    gtk4
    libadwaita
    cairomm
    atkmm
    pango
    gdk-pixbuf
    gdk-pixbuf-xlib
    webkitgtk
    gtk-layer-shell
    libctl
  ];
}
