{ config, pkgs, ... }:
let
  configDir = "${./config}";
  dirs = builtins.attrNames (builtins.readDir configDir);
in
{
  home.username = "ibmorr";
  home.homeDirectory = "/home/ibmorr";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  stylix.enableReleaseChecks = false;

  programs.bash = {
    enable = true;

    shellAliases = {
      update_pls = "sudo nix flake update --flake ${config.home.homeDirectory}/.config/nixos/.; sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.config/nixos/.";
      nwd = "cd ${config.home.homeDirectory}/.config/nixos";
    };
  };

  home.file = 
      (builtins.listToAttrs 
        (map 
          (dotfile: {
            name = ".config/${dotfile}";
            value = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/config/${dotfile}";
            };
          }
          ) 
        dirs)
      );

  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/muzika";
      extraConfig = ''
        audio_output {
            type "pipewire"
            name "pipewire output"
        }
      '';
    };
  };
}
