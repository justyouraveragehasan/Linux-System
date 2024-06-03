# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
 
  # Set your time zone.
  time.timeZone = "Europe/London";

  hardware.pulseaudio.enable = true;

  # Select internationalisation properties.
 
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  
  environment.pathsToLink = ["/libexec"];
 
  # Configure X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
    
    enable = true;
    
    displayManager = { 
     defaultSession ="none+i3";
     };
    
     windowManager.i3 = {
       enable = true;
       extraPackages = with pkgs; [
         dmenu
         i3status
         i3lock
         i3blocks
       ];
     };
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hasan = {
    isNormalUser = true;
    description = "hasan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     git
     kitty
     firefox
     nitrogen
     picom
     pywal
     neovim
     fastfetch
     polybar
     auto-cpufreq
     pavucontrol
     xclip
     acpi
  ];
 
  fonts.packages = with pkgs; [
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fonts.fontDir.enable = true;

  console = {
    enable = true;   
    packages = with pkgs; [(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })];
    #font = "/run/current-system/sw/share/X11/fonts/JetBrainsMonoNerdFont-Regular.ttf"; 
  };

  services.auto-cpufreq.enable = true;

  nix.settings.experimental-features = ["nix-command flakes"];
   
  programs.bash.shellAliases = {
    nvim = "nix run github:justyouraveragehasan/nvim-config";
  };
  
  programs.bash.loginShellInit = "wal -i Linux-System/WM/Wallpapers/wallpaper_japan.png -b 3c3838";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
