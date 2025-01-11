{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.printing {
    services.printing = {
      enable = true;
      drivers = with pkgs; [ hplip ];
      startWhenNeeded = true;
    };
    hardware.printers = {
    # TODO Change to your info
      ensurePrinters = [
        {
          name = "HP_ENVY_Pro_6400";
          location = "Home";
          deviceUri = "https://hpe6b24d.lan";
          model = "drv:///hp/hpcups.drv/hp-envy_pro_4500_series.ppd";
        }
      ];
      ensureDefaultPrinter = "HP_ENVY_Pro_6400";
    };
  };
}
