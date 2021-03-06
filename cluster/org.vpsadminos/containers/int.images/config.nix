{ config, pkgs, lib, confLib, data, ... }:
let
  proxy = confLib.findConfig {
    cluster = config.cluster;
    domain = "org.vpsadminos";
    location = null;
    name = "proxy";
  };
in {
  imports = [
    ../../../../environments/base.nix
  ];

  networking = {
    firewall.extraCommands = ''
      # Allow access from proxy
      iptables -A nixos-fw -p tcp --dport 80 -s ${proxy.addresses.primary.address} -j nixos-fw-accept
    '';
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "images.vpsadminos.org" = {
        root = "/srv/images";
        locations = {
          "/" = {
            extraConfig = "autoindex on;";
          };
        };
      };
    };
  };
}
