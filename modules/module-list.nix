let
  shared = [
    ./cluster
    ./config/service-definitions.nix
    ./misc/conf-lib.nix
    ./programs/havesnippet.nix
    ./system/monitoring.nix
  ];

  nixos = [
    ./services/monitoring/prometheus/rules.nix
    ./services/netboot.nix
    ./services/sachet.nix
    ./system/logging/nixos.nix
  ];

  vpsadminos = [
    ./cluster/configs/node.nix
    ./system/logging/vpsadminos.nix
  ];
in {
  nixos = shared ++ nixos;
  vpsadminos = shared ++ vpsadminos;
}
