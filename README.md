## NixOs dotfiles
Paths and account name are hardcoded inside config and home files so change it.

Clone this, copy hardware config from etc/nixos and run

`sudo nixos-rebuild switch --flake .`


Navidrome and mpd have scrobblers that need things like apikeys ets.

Just look into services.nix and respective docs and you will be good.
