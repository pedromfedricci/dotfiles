{...}: {
  # Power management.
  # Either run powertop auto tune on boot, tlp or power-profiles-daemon services.
  # Links:
  # https://nixos.wiki/wiki/Laptop
  # https://wiki.nixos.org/wiki/Power_Management
  #
  # NOTE: In practice, these are mutually exclusive, will throw assertion error
  # (power + tlp) or will overlap significantly.
  services.power-profiles-daemon.enable = true; # Default: false, true with GNOME.
  services.tlp.enable = false; # Default: false.
  services.tuned.enable = false; # Default: false.
  powerManagement.powertop.enable = false; # Default: false.

  # A DBus service that provides power management support to applications.
  services.upower.enable = true;

  # Add swap devices and files.
  swapDevices = [
    {
      device = "/var/swapfile";
      size = 16 * 1000; # 16GB
      randomEncryption.enable = false;
    }
  ];

  # boot.resumeDevice = "/var/swapfile";

  # Power suspend and hibernation.
  #
  # Move from suspend into hibernate after some specified duration.
  #
  # https://www.freedesktop.org/software/systemd/man/latest/systemd-sleep.conf.html
  # https://www.freedesktop.org/software/systemd/man/latest/systemd-suspend-then-hibernate.service.html
  # https://docs.kernel.org/admin-guide/pm/sleep-states.html#basic-sysfs-interfaces-for-system-suspend-and-hibernation
  # https://discourse.nixos.org/t/suspend-then-hibernate/31953
  systemd.sleep.extraConfig = ''
    #AllowSuspend=no
    #AllowHibernation=no
    #AllowSuspendThenHibernate=no
    #AllowHybridSleep=no
    MemorySleepMode=s2idle
    SuspendState=mem freeze disk
    SuspendEstimationSec=
    HibernateMode=platform suspend shutdown
    HibernateOnACPower=yes
    HibernateDelaySec=3h
  '';

  # Enable systemd to dinamically determine hibernation details.
  # https://discourse.nixos.org/t/is-it-possible-to-hibernate-with-swap-file/2852/5
  boot.initrd.systemd.enable = true;
}
