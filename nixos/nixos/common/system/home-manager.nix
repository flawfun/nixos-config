{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];
  home-manager.users.kyler =
    { lib, pkgs, ... }:
    {
      home = {
        username = "kyler";
        homeDirectory = "/home/kyler";
        stateVersion = "24.11";
      };
      programs = {
        home-manager.enable = true;

        bash = {
          enable = true;

          initExtra = ''
            eval "$(starship init bash)"
          '';

          sessionVariables = {
            NIXPKGS_ALLOW_UNFREE = 1;
          };

          shellAliases = {
            ".." = "cd ..";
            gc = "sudo nix-store --gc && sudo nix-collect-garbage -d";
            ll = "ls -lah";
            switch = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
            update = "nix flake update";
          };
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        git = {
          enable = true;
          userName = "flawfun";
          userEmail = "kylersmashnbash@gmail.com";
        };

        neovim = {
          enable = true;
          defaultEditor = true;
          extraPackages = with pkgs; [
            # programs
            git
            lemonade
            ripgrep
            wl-clipboard
            xclip

            # runtimes
            clang
            nodejs
            python3

            # bash
            nodePackages.bash-language-server
            shfmt

            # javascript
            vscode-langservers-extracted
            nodePackages.typescript-language-server
            nodePackages.svelte-language-server

            # lua
            luajitPackages.lua-lsp

            # nix
            nixd
            nixfmt-rfc-style
          ];
        };

        ssh = {
          enable = true;
          compression = true;

          matchBlocks = {
            "github.com" = {
              hostname = "github.com";
              user = "git";
              identityFile = "/home/kyler/.ssh/keys/github";
            };
          };
        };

      };
      xdg = {
        configFile."nvim".source = inputs.neovim-config;
      };
    };
}
