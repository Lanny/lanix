with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "wifistatus";
  description = "Pretty wifi status for i3status-rust";

  src = ./src;
  wifistatus-src = builtins.readFile src/wifistatus.sh;
  wifistatus = (pkgs.writeScriptBin name wifistatus-src).overrideAttrs(old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });

  buildInputs = [ wifistatus ];

  installPhase = ''
    cp ${wifistatus}/bin/wifistatus $out
  '';
}
