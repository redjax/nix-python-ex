{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    packages."x86_x64-linux".default = derivation {
      name = "simple";
      builder = "${inputs.nixpkgs.legacyPackages."x86_x64-linux".bash}/bin/bash";
      args = [ "-c" "echo foo > $out" ];
      src = ./.;
      system = "x86_x64-linux";
    };
  };
}