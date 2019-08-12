{ config, ... }:
{
  cluster."vpsadminos.org".global.www = rec {
    type = "container";
    spin = "nixos";
    addresses = {
      v4 = [ { address = "37.205.14.58"; prefix = 32; } ];
      v6 = [ { address = "2a03:3b40:fe:48::1"; prefix = 64; } ];
    };
    services.node-exporter = {};
  };
}
