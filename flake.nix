{
  description = "pdmfed's NixOS and Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { unstable, stable, home-manager, ... }:
    let
      host = {
        hostName = "thinkpad";
        system = "x86_64-linux";
        timeZone = "America/Sao_Paulo";
      };
      user = {
        userName = "Pedro Fedricci";
        userEmail = "pedromfedricci@gmail.com";
        username = "pdmfed";
        homeDirectory = "/home/${user.username}";
      };
      pkgs = unstable.legacyPackages.${host.system};

    in {
      nixosConfigurations.${host.hostName} = stable.lib.nixosSystem {
        system = host.system;     
        modules = [ (./host + ("/" + host.hostName)) ];
        specialArgs = { inherit host; };
      };

      homeConfigurations.${user.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit user; };
      };
    };
}
