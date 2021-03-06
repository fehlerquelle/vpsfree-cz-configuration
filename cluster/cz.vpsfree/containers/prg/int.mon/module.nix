{ config, ... }:
{
  cluster."cz.vpsfree".prg."int.mon" = rec {
    type = "container";
    spin = "nixos";
    container.id = 14005;
    addresses.primary = { address = "172.16.4.10"; prefix = 32; };
    services = {
      node-exporter = {};
      prometheus = {};
    };
    monitoring.isMonitor = true;
  };
}
