{
  pkgs,
  host,
  user,
  ...
}: {
  # See kernel versions at `linuxKernel.kernels`:
  # linux stable: `linux`
  # - linux testing: `linuxKernel.kernels.linux_testing`
  # - zen kernel: `linuxKernel.kernels.linux_zen`
  # Package options:
  # - stable latest: `linuxPackages_latest`
  # - testing latest: `linuxPackages_testing`
  # - zen latest: `linuxPackages_zen`
  boot.kernelPackages = pkgs.stable.linuxPackages_zen;

  # Add thinkpad acpi to kernel modules.
  boot.kernelModules = ["thinkpad_acpi"];

  # Parameters added to the kernel command line.
  boot.kernelParams = [
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = host.timeZone;

  # Enable nixos-init, a bashless initialization system for systemd initrd.
  # Links:
  # https://mynixos.com/nixpkgs/package/nixos-init
  # https://mynixos.com/nixpkgs/option/system.etc.overlay
  # https://mynixos.com/nixpkgs/option/services.userborn
  # NOTE: EXPERIMENTAL. All enabled required.
  system.nixos-init.enable = false;
  system.etc.overlay.enable = false;
  services.userborn.enable = false;

  # Avahi is a system which facilitates service discovery on a local network.
  # It is an implementation of the mDNS.
  # NOTE: Used to detect network printers that support IPP Everywhere protocol.
  # Link: https://mynixos.com/nixpkgs/options/services.avahi
  services.avahi = {
    enable = false;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable CUPS to print documents and printing drivers.
  # NixOS printing wiki: https://nixos.wiki/wiki/Printing.
  services.printing = {
    enable = false;
    drivers = [
      # pkgs.epson-escpr
    ];
  };

  # Enable WiFi printer detection.
  # NixOS scanner wiki: https://nixos.wiki/wiki/Scanners.
  # Scanner support provided by SANE. Link: https://www.sane-project.org/.
  hardware.sane = {
    enable = false;
    # Default `escl` backend couldn't find the Epson scanner.
    # Epson XP-211-214-216 Series scanner and others.
    #
    # extraBackends = [pkgs.sane-airscan];
  };

  # RealtimeKit system service, which hands out realtime scheduling priority
  # to user processes on demand.
  # NOTE: PipeWire use this to acquire realtime priority.
  # Link: https://mynixos.com/nixpkgs/option/security.rtkit.enable
  security.rtkit.enable = true;

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # Enable PipeWire PulseAudio compatibility layer.
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this
    #
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is
    # enabled by default, no need to redefine it in your config for now)
    #
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  #
  # services.xserver.libinput.enable = true;

  # Enable libvirt.
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
    };
  };

  # Enable container virtualization.
  virtualisation = {
    containers.enable = true;
    # Link: https://wiki.nixos.org/wiki/Podman
    podman = {
      # Enable podman.
      enable = true;
      # Create docker to podman alias.
      dockerCompat = false; # Default: false.
      # Required for podman-compose containers to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    # Link: https://wiki.nixos.org/wiki/Docker/en
    docker = {
      # NOTE: Enable both docker and rootless daemon.
      enable = false;
      # daemon.settings.experimental = true;
      # Rootless docker.
      # Links:
      # https://docs.docker.com/engine/security/rootless/
      # https://wiki.nixos.org/wiki/Docker#Rootless_Docker
      # rootless = {
      #   # NOTE: Enable both docker and rootless daemon.
      #   #
      #   enable = true;
      #
      #   # Set DOCKER_HOST to rootless Docker for normal users by default.
      #   #
      #   setSocketVariable = true;
      # };
    };
  };

  # Enable and set zsh as users' default shell.
  environment.shells = with pkgs; [bash fish];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.bash;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.userName;
    extraGroups = ["libvirtd" "networkmanager" "wheel" "podman" "docker" "scanner" "lp"];
    shell = pkgs.fish;
    # Add your SSH public key(s) here, if you plan on using SSH to connect.
    openssh.authorizedKeys.keys = [
    ];

    # Select user specific packages, better use home-manager though.
    packages = [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    grub2
    openssl
    pkg-config
  ];

  # List of pograms to enable in system profile.
  programs = {
  };

  # Run unpatched dynamic binaries on NixOS.
  # Ref: https://github.com/nix-community/nix-ld
  # Ref: https://discourse.nixos.org/t/sqlalchemy-python-fails-to-find-libstdc-so-6-in-virtualenv/38153/2
  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [
    # zlib # numpy
    # libgcc # sqlalchemy
    # stdenv.cc.cc.lib
    # ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # Enable fwupd, a DBus service that allows applications to update firmware.
  # Firmware updates supported by LSFS for this system:
  # https://fwupd.org/lvfs/devices/com.lenovo.ThinkPadR2AET.firmware
  # Short guide:
  # https://www.cyberciti.biz/faq/thinkpad-update-firmware-on-linux-x1-extreme-p1-gen2/
  #
  # NOTE: Can't update FPC Fingerprint Reader Firmware from 27.26.23.23 to 27.26.23.50.
  # Issue link: https://github.com/fwupd/fwupd/issues/5573:
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
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
