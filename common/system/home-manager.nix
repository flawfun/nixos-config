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

#         git = {
#           enable = true;
#           userName = "";
#           userEmail = "";
#         };

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

      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 300;
            command = ''${lib.getExe pkgs.curl} -s --json '{"method": "resume", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc'';
            resumeCommand = ''${lib.getExe pkgs.curl} -s --json '{"method": "pause", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc'';
          }
        ];
      };

      xdg = {
        # configFile."nvim".source = "/home/kyler/code/neovim-config/";
        configFile."nvim".source = inputs.neovim-config;
      };
    };
}; }
