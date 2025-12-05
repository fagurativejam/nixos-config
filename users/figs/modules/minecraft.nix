#need to set up port forwarding for nonlocal (WAN)
#for LAN its just 'local ip address':'port id'
#for WAN its 'public ip address':'port id'
  #environment.systemPackages.pkgs.minecraft-server
  # services.minecraft-server ={
  #   enable = true;
  #   eula = true;
  #   openFirewall = true;
  #   declarative = true;
  #   whitelist = {
  #       figurativejam = "cffa5882-3659-4806-9005-edf89046ed2f";
  #   };
  #   serverProperties = {
  #     server-port = 25565;
  #     difficulty = "normal";
  #     gamemode = "survival";
  #     max-players = 7;
  #     motd = "Figs's Minecraft Server!";
  #     level-name = "Fart World";
  #   };
  #   jvmOpts = "-Xms2048M -Xmx4096M";
  # };

  # environment.etc."minecraft/ops.json".text = ''
  #   [
  #     {
  #       "uuid": "cffa5882-3659-4806-9005-edf89046ed2f",
  #       "name": "figurativejam",
  #       "level": 4,
  #       "bypassesPlayerLimit": false
  #     }
  #   ]
  # '';