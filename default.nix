{
  pkgs ? import <nixpkgs> { }
}:
pkgs.stdenv.mkDerivation {
  name = "mkfatimg";
  src = ./.;
  buildInputs = [ pkgs.makeWrapper pkgs.shellcheck ];
  installPhase = ''
    mkdir -p $out/bin
    cp mkfatimg.sh $out/bin/mkfatimg.sh
  '';
  doCheck = true;
  checkPhase = ''
    shellcheck mkfatimg.sh
  '';
  postFixup = ''
    makeWrapper $out/bin/mkfatimg.sh $out/bin/mkfatimg --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.file pkgs.mtools pkgs.unzip ]}
  '';
}
