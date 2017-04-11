{ pkgs ? import ./nixpip/data/nixpkgs.nix
, nixpip_nix ? ./nixpip/data/nixpip.nix
, deployment ? "user"
}:

with pkgs;

let

  nixpip = callPackage nixpip_nix {
    requirements_nix = ./requirements.nix;
    runtime = ./requirements.open;
    testing = ./test_requirements.open;
  };

  version = builtins.readFile ./nixpip/VERSION;

  name = {
    user = "runtime";
    dev  = "all";
  }."${deployment}";

  buildInputs = [
    nixpip.python."${name}"
    cacert
    libffi
    openssl
    pkgconfig
    sqlite
    zlib
  ];

in

pythonPackages.buildPythonApplication {
  inherit version;
  name = "nixpip-${version}";
  BuildInputs = buildInputs;
  propagatedBuildInputs = nixpip.requirements."${name}";
  src = ./.;
}
