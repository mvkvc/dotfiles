{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;

  unstable = import <nixpkgs-unstable> { 
    config = { allowUnfree = true; };
  };
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  users.users.mvkvc.isNormalUser = true;

  home-manager.users.mvkvc = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      htop
      neofetch
      git
      direnv
      neovim
      claude-code
      gemini-cli
      unstable.qwen-code
      bitwarden
      thunderbird
      vscodium-fhs
    ];

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(direnv hook bash)"
      '';
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };
    };

    programs.git = {
      enable = true;
      userName = "Marko Vukovic";
      userEmail = "git@mvk.vc";
    };

    home.stateVersion = "25.05";
  };
}
