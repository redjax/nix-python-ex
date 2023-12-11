{
  description = "Example Python package with a NixOS flake.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_x64-linux =
    with import nixpkgs { system = "x86_x64-linux"; };
    stdenv.mkDerivation {
      name = "hello";
      src = self;
      buildPhase = "gcc -o hello ./hello.c";
      installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
    };

  };
}