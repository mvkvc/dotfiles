{
  config,
  pkgs,
  lib,
  ...
}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";

  unstable = import <nixpkgs-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.mvkvc = {
    isNormalUser = true;
    extraGroups = [ "docker" ];
  };

  home-manager.users.mvkvc =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      home.packages = with pkgs; [
        htop
        wget
        tree
        ripgrep
        neofetch
        just
        git
        direnv
        neovim
        nixfmt-rfc-style
        claude-code
        unstable.qwen-code
        ollama
        docker-compose
        bitwarden
        vscodium-fhs
        fira-code
        logseq
        hexchat
        discord
      ];

      programs.bash = {
        enable = true;
        bashrcExtra = ''
          eval "$(direnv hook bash)"
        '';
        shellAliases = {
          vi = "nvim";
          vim = "nvim";
          code = "codium";
        };
      };

      programs.git = {
        enable = true;
        userName = "Marko Vukovic";
        userEmail = "git@mvk.vc";
        extraConfig = {
          push.autoSetupRemote = true;
        };
      };

      services.ollama.enable = true;

      home.stateVersion = "25.05";
    };
}
