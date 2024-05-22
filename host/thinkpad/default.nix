# This is your system's configuration file.
# Use this to configure your system environment (it replaces
# /etc/nixos/configuration.nix).
{
  pkgs,
  inputs,
  host,
  user,
  ...
}: {
  # You can import other NixOS modules here.
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.hosts.nixosModule
    {networking.stevenBlackHosts.enable = true;}
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Override linux kernel version since nixos-23.11 ships linux 6.1 but my
  # wireless card (Realtek RTL8852BE) driver is only supported by linux >= 6.3.
  # Driver: RTW89_8852be.
  boot.kernelPackages = pkgs.linuxPackages_6_8;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define your hostname.
  networking.hostName = host.hostName;

  # Enables wirless support via wpa_supplicant.
  # networking.wireless.enable = true;

  # Configure network proxy if necessary.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = host.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is
    # enabled by default, no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable libvirt.
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      ovmf.packages = [
        (pkgs.OVMF.override {
          # secureBoot = true; # Not sure about this one.
          tpmSupport = true;
        })
        .fd
      ];
    };
  };
  # Already set on hardware-configuraon.nix.
  # boot.kernelModules = ["kvm-amd"];

  # Enable and set zsh as users' default shell.
  environment.shells = with pkgs; [bash zsh];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.userName;
    extraGroups = ["libvirtd" "networkmanager" "wheel"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to
      # connect.
    ];

    # Select user specific packages, better use home-manager though.
    # packages = with pkgs; [
    # firefox
    # thunderbird
    # ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Allow broken packages.
  # nixpkgs.config.allowBroken = true;

  # Allow flakes experimental feature.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Storage optimization: https://nixos.wiki/wiki/Storage_optimization.

  # Automatically create hard links for identical content in the store,
  # saving disk space. Runs every build, may slow it down.
  nix.settings.auto-optimise-store = true;

  # Automates nix garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # fprintd # Unsupported.
    clang
    gcc
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnupg
    grub2
    inputs.helix.packages.${pkgs.system}.helix
    openssl
    pop-launcher
    pkg-config
    vagrant
    wl-clipboard
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  #
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Device 10a5:9800 is not supported by libfprint.
  # https://gitlab.freedesktop.org/libfprint/wiki/-/wikis/Unsupported-Devices
  # services.fprintd.enable = true;

  services.flatpak.enable = false;
  services.gnome.gnome-browser-connector.enable = true;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = false;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords.
      PasswordAuthentication = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}