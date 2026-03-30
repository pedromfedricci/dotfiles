{
  # Links:
  # https://www.mankier.com/5/NetworkManager.conf
  # https://mynixos.com/nixpkgs/options/networking
  flake.nixosModules.networking = {host, ...}: {
    # Enable networking.
    networking.networkmanager.enable = true;

    # The list of nameservers. If left empty it will auto-detected through DHCP.
    # https://mynixos.com/nixpkgs/option/networking.nameservers
    # NOTE: Google and Cloudflare main DNS IPs already in the fallback list.
    networking.nameservers = [
      "1.1.1.3#cloudflare-dns.com"
      "1.0.0.3#cloudflare-dns.com"
      "2606:4700:4700::1113#cloudflare-dns.com"
      "2606:4700:4700::1003#cloudflare-dns.com"
      # "8.8.8.8#dns.google"
      # "8.8.4.4#dns.google"
      # "2001:4860:4860::8888#dns.google"
      # "2001:4860:4860::8844#dns.google"
    ];

    # Systemd DNS resolver daemon (systemd-resolved).
    # https://www.mankier.com/5/resolved.conf
    # https://mynixos.com/nixpkgs/options/services.resolved.settings.Resolve
    services.resolved = {
      enable = true;
      # DNS = config.networking.nameservers; # Default: nameservers
      dnssec = "allow-downgrade"; # Default: false
      dnsovertls = "opportunistic"; # Default: false
    };

    # Driver: RTW_8852be, only in-kernel from linux >= 6.3 onwards.
    # Out-of-tree driver from lwfinger's rtw89 on github. Check README for Lenovo
    # fix over their faulty BIOS constantly dropping connection over wifi.
    #
    # boot.extraModulePackages = [(pkgs.rtw89-git)];
    # boot.kernelModules = ["rtw89"];

    networking.networkmanager.wifi.powersave = true; # Default: null.

    # Define your hostname.
    networking.hostName = host.hostName;

    networking.wireless.iwd = {
      enable = true; # Default: false
      # Links:
      # https://www.mankier.com/5/iwd.config
      settings = {
        Rank = {
          BandModifier6Ghz = "3.0";
          BandModifier5Ghz = "2.0";
          BandModifier2_4Ghz = "0.5";
        };
      };
    };

    networking.networkmanager.wifi.backend = "iwd";

    # Enables wirless support via wpa_supplicant.
    # networking.wireless.enable = true; # Default: false

    # Configure network proxy if necessary.
    #
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    #
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    #
    # Or disable the firewall altogether.
    #
    # networking.firewall.enable = false;
  };
}
