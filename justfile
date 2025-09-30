help:
    @just --list

backup:
    cp ~/.vscode-oss/extensions/extensions.json ./vscode-oss/extensions.json

    git add .
    git commit -m "backup" || true
    git push

restore:
    mkdir -p ~/.vscode-oss/extensions
    cp -i ./vscode-oss/extensions.json ~/.vscode-oss/extensions/extensions.json

switch:
    sudo nixos-rebuild switch -I nixos-config=./nix/configuration.nix

test:
    sudo nixos-rebuild test -I nixos-config=./nix/configuration.nix
