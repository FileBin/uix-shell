{ pkgs, stdenv }:
with pkgs;
let
  name = "uix-shell";
in
stdenv.mkDerivation {
  pname = name;
  version = "0.1";

  src = ./.;

  buildInputs = [ 
    libnotify 
    xdg-utils 
  ];

  installPhase = 
  let 
    desktopEntry = pkgs.makeDesktopItem {
      name = name;
      desktopName = name;
      exec = "${name} %f";
      icon="nix-snowflake";
      mimeTypes = [
        "text/x-uix"
      ];
    };
  in
  ''
    mkdir -p $out/bin

    cp -r ./bin $out/
    cp -r ./share $out/

    cat <<EOF > $out/share/deps.env
      NOTIFY_SEND=${libnotify}/bin/notify-send
      XDG_OPEN=${xdg-utils}/bin/xdg-open
    EOF

    mkdir -p $out/share/applications
    cp ${desktopEntry}/share/applications/${name}.desktop $out/share/applications/${name}.desktop

    chmod +x $out/bin/uix-shell
  '';
}