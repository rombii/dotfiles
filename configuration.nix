{config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./services.nix
      ./nvf-config.nix
      ./packages.nix
      ./stylix.nix
    ];

  nix.settings = {
    build-dir = "";
    download-buffer-size = 524288000;
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth = {
      enable = true;
      themePackages = with pkgs; [ nixos-bgrt-plymouth ];
    };
  };

  swapDevices = lib.mkForce [ ];

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ 2234 4533 ];

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  i18n.extraLocales = [
    "ja_JP.UTF-8/UTF-8"
  ];

  users.users.ibmorr = {
    isNormalUser = true;
    description = "ibmorr";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
    packages = with pkgs; [];
    home = "/home/ibmorr";
  };

  users.groups.docker.members = [ "ibmorr" ];
  users.groups.libvirtd.members = [ "ibmorr" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBINPUT_ACCEL_PROFILE = "flat";
    EDITOR = "nvim";
  };

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.iosevka
    nerd-fonts.roboto-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    noto-fonts
    noto-fonts-cjk-sans
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  }; 

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia.modesetting.enable = true;
    nvidia.powerManagement.enable = false;
    nvidia.powerManagement.finegrained = false;
    nvidia.open = false;
    nvidia.nvidiaSettings = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    opentabletdriver.enable = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "25.05";
  security.rtkit.enable = true;

  # Fix for permission issues with navidrome
  systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce false;
  programs.virt-manager.enable = true;
  programs.starship.enable = true;
  programs.gamemode.enable = true;
  
  
  
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
