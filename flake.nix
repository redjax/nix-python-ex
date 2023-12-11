{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = inputs: {
    packages."x86_64-linux".default = derivation {
      name = "simple";
      builder = "${inputs.nixpkgs.legacyPackages."x86_64-linux".bash}/bin/bash";
      args = [ "-c" "echo foo > $out" ];
      src = ./.;
      system = "x86_64-linux";
    };
  };
}
