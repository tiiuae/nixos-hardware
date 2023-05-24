final: _prev: {
  uboot-tc-saluki = final.callPackage ./uboot { pkgs = final; targetBoard = "microchip_mpfs_icicle";};
}
