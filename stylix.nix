{pkgs, ...}:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
  stylix.targets.nvf.enable = false;
}
