{ config, lib, pkgs, ...}:
{
  imports = [
    ../common.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.bash.root.historyPools = [ "tank" ];

  boot.zfs.pools = {
    tank = {
      datasets = {
        "/".properties = {
          compression = "on";
        };
        "ct".properties = {
          acltype = "posixacl";
          sharenfs =
            let
              networks = (import ../../../data/networks/management.nix).ipv4;
              property = lib.concatMapStringsSep "," (net:
                "rw=@${net.address}/${toString net.prefix}"
              ) networks;
            in property;
        };
      };
    };
  };
}