{pkgs, ...}:
let
  customSddmTheme = pkgs.sddm-astronaut.overrideAttrs(old: {
    installPhase = ''
      ${old.installPhase}
      chmod -R 777 $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds
      cp ${./assets/sddm_bg.png} $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/astronaut.png
        
      chmod -R 777 $out/share/sddm/themes/sddm-astronaut-theme/Themes
      cp ${./assets/sddm_theme.conf} $out/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    wget
    kitty
    waybar
    git
    rofi
    vesktop
    fastfetch
    ntfs3g
    cava
    parted
    floorp-bin
    progress
    wineWowPackages.stable
    lutris
    hyprpaper
    winetricks
    protontricks
    nvitop
    gamescope
    vulkan-loader
    vulkan-tools
    hyprpolkitagent
    swaynotificationcenter
    nerd-fonts.roboto-mono
    nerd-fonts.jetbrains-mono
    nerdfix
    easyeffects
    rmpc
    bat
    manix
    wallust
    customSddmTheme
    mpd-mpris
    gruvbox-plus-icons
    nwg-look
    nicotine-plus
    puddletag
    wowup-cf
    flameshot
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    virt-manager
    unrar-free
    jetbrains.rider
    dotnetCorePackages.sdk_8_0_3xx
    dotnet-ef
    krita
    unzip
    mpv
    ani-cli
    ffmpeg-full
    azure-cli
    dysk
    starship
    htop-vim
    lm_sensors
    lf
    ctpv
    chafa
    zig
  ];
}
