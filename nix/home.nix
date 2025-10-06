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
        neofetch
        htop
        tree
        curl
        wget
        dig
        git
        just
        direnv
        neovim
        docker-compose
        claude-code
        unstable.qwen-code
        ollama
        nixfmt-rfc-style
        fira-code
        bitwarden
        vscodium-fhs
        sublime-merge
        logseq
        hexchat
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
          init.defaultBranch = "master";
          advice.defaultBranchName = false;
        };
      };

      services.ollama.enable = true;

      home.stateVersion = "25.05";
    };
}
