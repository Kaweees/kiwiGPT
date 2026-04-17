{
  pkgs ? import <nixpkgs> { config.allowUnfree = true; },
}:

let
  python = pkgs.python312;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    python
    uv
    nixfmt
    just
    stdenv.cc.cc.lib
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
  ];

  # Shell hook to set up environment
  shellHook = ''
    export TMPDIR=/tmp
    export UV_PYTHON="${python}/bin/python"
    just install
  '';
}
