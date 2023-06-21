final: _prev: {
  uboot-polarfire = final.callPackage ./uboot { pkgs = final; targetBoard = "microchip_mpfs_icicle";};
}
