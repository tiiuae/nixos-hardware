{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import ./overlay.nix)
  ];

  imports = [
    ./modules.nix
  ];

  hardware.deviceTree = {
    name = "microchip/mpfs-icicle-kit.dtb";
  };
}
