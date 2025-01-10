{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
    };

    extraOptions.gui = {
      user = "kyler";
      password = "password";
    };

    folders = {
      "geometry-dash" = {
        path = "~/geometry-dash";
        devices = [
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "3";
            cleanoutDays = "14";
          };
        };

      };
      "unrailed" = {
        path = "~/unrailed";
        devices = [
          "Mythra"
          "steamdeck"
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "3";
            cleanoutDays = "14";
          };
        };
      };

    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 8384 ];
  };
}
