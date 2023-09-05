{ pkgs, ... } @ args:
with pkgs;
let
  prune = import ./configs/prune.nix;
  nixos = import ./configs/nixos.nix;
  hardened = import ./configs/hardened.nix;
  docker = import ./configs/docker.nix;
  mesh = import ./configs/mesh.nix;
  media = import ./configs/media.nix;
  inbuilt-fw = fetchFromGitHub {
    owner = "codehub8";
    repo = "tc_firmware";
    rev = "004dbcad4c3284d556ab98305a46edcb55a58f4a";
    sha256 = "sha256-+HT99dh4C9ctP1vmObcLBbxrkZVBUWLCV++xAeg2P+I";
  };

in
buildLinux (args // rec {
  version = "5.15.92-hardened1";
  modDirVersion = version;

  nativeBuildInputs = [openssl ssh];
  defconfig = "mpfs_defconfig";

  kernelPatches = [
  {
    name = "emc2301";
    patch = ./patches/0001-Import-emc2301-fan-driver-into-staging.patch;
  }
  {
    name = "max1726";
    patch = ./patches/0002-Import-max1726x-gauge-driver-into-staging.patch;
  }
  {
    name = "bq25980";
    patch = ./patches/0003-Fix-battery-charging-current-configuration.patch;
  }
  {
    name = "ath9k-chbw";
    patch = ./patches/0004-Add-channelbw-debugfs-support-for-ath9k.patch;
  }
  {
    name = "ath9k-LR";
    patch = ./patches/0005-Add-ath9k-long-range-tweaks.patch;
  }
  {
    name = "nrc7292";
    patch = ./patches/0006-Add-Halow-Newracom-driver-to-staging.patch;
  }
  {
    name = "nrc7292-hspi-irq";
    patch = ./patches/0008-nrc-Add-support-to-enable-GIC-HSPI_EIRQ.patch;
  }
  {
    name = "nrc7292-kbuild";
    patch = ./patches/0009-Fix-Makefile-for-nrc-driver-build-for-SPI.patch;
  }
  {
    name = "user-regdb";
    patch = ./patches/0007-ath-Ignore-regulatory-domain-in-EEPROM.patch;
  }
  ];

  autoModules = false;
  extraConfig = prune + hardened + docker + mesh + media + nixos +
  ''
    EXTRA_FIRMWARE ath10k/QCA6174/hw3.0/board-2.bin ath10k/QCA6174/hw3.0/firmware-6.bin ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988X/hw2.0/firmware-4.bin ath10k/QCA988X/hw2.0/firmware-5.bin regulatory.db regulatory.db.p7s
    EXTRA_FIRMWARE_DIR ${inbuilt-fw}
    FW_LOADER_COMPRESS n
  '';

  src = fetchGit {
    url = "ssh://git@github.com/tiiuae/tc_linux.git";
    rev = "9263d02a0883cf0deb012225ce1ccaabfd93fa9a";
    ref = "tc-saluki-5.15-sec";
  };
} // (args.argsOverride or { }))
