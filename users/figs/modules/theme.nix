{pkgs,...}:

let
  # Parsers (translate raw hex)
    sub = start: len: str: builtins.substring start len str;

    hexToDec = hexStr: toString (
      let
        mapping ={"0"=0;"1"=1;"2"=2;"3"=3;"4"=4;"5"=5;"6"=6;"7"=7;"8"=8;"9"=9;"a"=10;"A"=10;"b"=11;"B"=11;"c"=12;"C"=12;"d"=13;"D"=13;"e"=14;"E"=14;"f"=15;"F"=15;};
        h1 = builtins.getAttr (sub 0 1 hexStr) mapping;
        h2 = builtins.getAttr (sub 1 1 hexStr) mapping;
      in (h1 * 16) + h2
    );

  # Public utility wrappers
    toRGBACss = hex: alpha: "rgba(${hexToDec (sub 0 2 hex)}, ${hexToDec (sub 2 2 hex)}, ${hexToDec (sub 4 2 hex)}, ${alpha})";
    toHyprHex = hex: alphaHex: "0x${alphaHex}${hex}";
    toHashHex = hex: "#${hex}";
    toTermParam = hex: "38;2;${hexToDec (sub 0 2 hex)};${hexToDec (sub 2 2 hex)};${hexToDec (sub 4 2 hex)}";
    toAnsi = hex: "\\e[${toTermParam hex}m";
  # MASTER PALETTE
    colors = {
      #Neutral Bases
      crust = "11111b"; #deepest dark "#11111b"
      mantle = "181825"; #mild dark "#181825"
      bg = "1e1e2e"; #base color "#1e1e2e"
      surface0 = "313244";#"#313244" 
      surface1 = "45475a"; #"#45475a"
      surface2 = "585b70"; #"#585b70"
      overlay0 ="6c7086"; #"#6c7086"
      overlay1 ="7f849c"; #"#7f849c"
      overlay2 ="9399b2"; #"#9399b2"
      subtext0 ="a6adc8"; #"#a6adc8"
      subtext1 ="bac2de"; #"#bac2de"
      fg0 = "cdd6f4"; #text color "#cdd6f4"
      fg1 = "b4befe"; #"#b4befe"
      fg2 = "f5e0dc"; #"#f5e0dc"
      white = "ffffff"; #"#eceff4"
      #vibrant accents
      purple1 = "cba6f7"; #"#cba6f7"
      red1="f38ba8";#"#f38ba8"
      maroon1="eba0ac";#"#eba0ac"
      orange1="fab387";#"#fab387"
      yellow1="f9e2af";#"#f9e2af"
      green1="a6e3a1";#"#a6e3a1"
      teal1="94e2d5";#"#94e2d5"
      cyan1="89dceb";#"#89dceb"
      darkblue1="74c7ec";#"#74c7ec"
      blue1 ="89b4fa";#"#89b4fa"
      pink1="f2cdcd";#"#f2cdcd"
      #accent pt 2 
      teal2="8fbcbb";#"#8fbcbb"
      cyan2="88c0d0";#"#88c0d0"
      darkblue2="5e81ac";#"##5e81ac" 
      blue2="81a1c1";#"#81a1c1"
      red2="b5616a";#"#b5616a"
      orange2="d08770";#"#d08770"
      yellow2="ebcb8b";#"#ebcb8b"
      green2="a3be8c";#"#a3be8c"
      purple2="b48ead";#"#b48ead"
      pink2="d699b4";#"#d699b4"
      maroon2="";#"#a2686a"
      #important colors
      porsche="ff0000";#"#ff0000"
      cerulean="33ccfe";#"#33ccfe"
  };
in {
  _module.args = {
    myTheme = {
        inherit colors toRGBACss toHyprHex toHashHex sub hexToDec toTermParam toAnsi;
    };
  };
}
