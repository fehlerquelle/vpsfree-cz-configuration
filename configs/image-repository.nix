{ config, pkgs, lib, ... }:
{
  boot.zfs.pools.tank.datasets = {
    "image-repository/build-scripts" = {};
    "image-repository/build-dataset" = {};
    "image-repository/cache" = {};
    "image-repository/log" = {};
    "image-repository/target" = {};
  };

  services.osctl.image-repository.vpsadminos = rec {
    path = "/tank/image-repository/target";
    cacheDir = "/tank/image-repository/cache";
    buildScriptDir = "/tank/image-repository/build-scripts";
    buildDataset = "tank/image-repository/build-dataset";
    logDir = "/tank/image-repository/log";

    rebuildAll = true;
    buildInterval = "0 4 * * sat";

    postBuild = ''
      ${pkgs.rsync}/bin/rsync -av --delete "${path}/" images.vpsadminos.org:/srv/images/
    '';

    vendors.vpsadminos = { defaultVariant = "minimal"; };
    defaultVendor = "vpsadminos";

    images = {
      alpine = {
        "3.8" = {};
        "3.9" = { tags = [ "latest" "stable" ]; };
      };

      arch.rolling = { name = "arch"; tags = [ "latest" "stable" ]; };

      centos = {
        "6" = {};
        "7" = { tags = [ "latest" "stable" ]; };
      };

      debian = {
        "8" = {};
        "9" = { tags = [ "latest" "stable" ]; };
      };

      devuan = {
        "2.0" = { tags = [ "latest" "stable" ]; };
      };

      fedora = {
        "29" = {};
        "30" = { tags = [ "latest" "stable" ]; };
      };

      gentoo.rolling = { name = "gentoo"; tags = [ "latest" "stable" ]; };

      nixos = {
        "19.03" = { tags = [ "latest" "stable" ]; };
        "unstable" = { tags = [ "unstable" ]; };
      };

      opensuse = {
        "leap-15.1" = { tags = [ "latest" "stable" ]; };
        "tumbleweed" = {};
      };

      slackware."14.2" = { tags = [ "latest" "stable" ]; };

      ubuntu = {
        "16.04" = {};
        "18.04" = { tags = [ "latest" "stable" ]; };
      };

      void = {
        "glibc" = { tags = [ "latest" "stable" "latest-glibc" "stable-glibc" ]; };
        "musl" = { tags = [ "latest-musl" "stable-musl" ]; };
      };
    };
  };
}
