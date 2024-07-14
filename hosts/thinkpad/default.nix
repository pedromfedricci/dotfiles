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
    ../../modules/nixos/fprintd-fpcmoh.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Override linux kernel version since nixos-23.11 ships linux 6.1 but my
  # wireless card (Realtek RTL8852BE) driver is only supported by linux >= 6.3.
  # Driver: RTW89_8852be.
  boot.kernelPackages = inputs.kernel.legacyPackages.${pkgs.system}.latest;

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
    LC_TIME = "en_US.UTF-8";
  };

  # Hintstyles: "slight" (default), "medium", "full".
  # fonts.fontconfig.hinting.style = "full";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver = {
    xkb.layout = "us,pt";
    xkb.variant = "";
  };

  # Enable CUPS to print documents and printing drivers.
  # NixOS printing wiki: https://nixos.wiki/wiki/Printing.
  services.printing = {
    enable = true;
    drivers = [
      # Epson XP-211-214-216 Series printer driver and others.
      pkgs.epson-escpr
    ];
  };

  # Enable WiFi printer detection.
  # NixOS scanner wiki: https://nixos.wiki/wiki/Scanners.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # Scanner support provided by SANE. Link: https://www.sane-project.org/.
  hardware.sane = {
    enable = true;
    # Default `escl` backend couldn't find the Epson scanner.
    # Epson XP-211-214-216 Series scanner and others.
    extraBackends = [pkgs.sane-airscan];
  };

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
    extraGroups = ["libvirtd" "networkmanager" "scanner" "wheel"];
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

  # Which nix package instance to use throughout the system.
  # On stable it is currenty at 1.18. Something greater or equal to 1.19
  # would be better, since that release fixed `nix flake lock` always
  # updating every existing input.
  # Link: https://nix.dev/manual/nix/2.23/release-notes/rl-2.19.
  nix.package = pkgs.nixVersions.nix_2_21;

  # Allow unfree packages (default false).
  nixpkgs.config.allowUnfree = true;

  # Allow broken packages (default false).
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
    clang
    gcc
    grub2
    helix
    openssl
    pkg-config
    vagrant
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

  # Enable fwupd, a DBus service that allows applications to update firmware.
  # Firmware updates supported by LSFS for this system:
  # https://fwupd.org/lvfs/devices/com.lenovo.ThinkPadR2AET.firmware
  # Short guide:
  # https://www.cyberciti.biz/faq/thinkpad-update-firmware-on-linux-x1-extreme-p1-gen2/
  services.fwupd.enable = true;

  # Enable flatpak, a linux application sandbox and distribution framework.
  services.flatpak.enable = false;

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
