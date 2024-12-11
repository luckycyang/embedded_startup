{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells = {
          default = pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
            name = "embedded";
            buildInputs = with pkgs; [
              cmake
              ninja
              coreboot-toolchain.arm # nameby arm-eabi-gcc
              triton-llvm # llvm tools collect
              gdb
              zig
              zls
              fd
              eza
            ];
          };
        };
        # flake contents here
      }
    );
}
