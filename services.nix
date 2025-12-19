{pkgs, lib, config, ...}:
let
  customSddmTheme = pkgs.sddm-astronaut.overrideAttrs(old: {
    installPhase = ''
      ${old.installPhase}
      chmod -R 770 $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds
      cp ${./assets/sddm_bg.png} $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/astronaut.png
        
      chmod -R 770 $out/share/sddm/themes/sddm-astronaut-theme/Themes
      cp ${./assets/sddm_theme.conf} $out/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
    '';
  });
  userHome = config.users.users.ibmorr.home;
in
{
  services = {
    xserver = {
      enable = true;
      dpi = 96;
      xkb = {
        layout = "pl";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };  
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire.adjust-sample-rate = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "defautlt.allowed-rates" = [ 48000 44100 ];
          "default.clock.quantum" = 510;
          "default.clock.min-quantum" = 510;
          "default.clock.max-quantum" = 550;
        };
      }; 
    };
    navidrome = {
      enable = true;
      openFirewall = true;
      group = "users";
      environmentFile = "${userHome}/.config/secrets/last_fm/api.env";
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "${userHome}/muzika";
        DataFolder = "${userHome}/navidrome";
        CacheFolder = "${userHome}/navidrome/cache";
        ProtectHome = false;
        LastFM.Enabled = true;
      };
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
          CursorTheme = "Notwaita-Grey";
          CursorSize = 24;
          EnableAvatars = true;
        };
      };
      extraPackages = with pkgs; [ customSddmTheme ];
    };
    mpdscribble = {
      enable = true;
      endpoints = {
        "last.fm" = {
          username = "ivmorr";
          passwordFile = "${config.users.users.ibmorr.home}/.config/secrets/last_fm/pass";
        };
      };
    };
  }; 
}
