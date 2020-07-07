{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "plantuml-server";
  version = "1.2020.15";

  src = fetchurl {
    url = "mirror://sourceforge/project/plantuml/${version}/plantuml.${version}.war";
    sha256 = "0b87p4x3w8ilck0n2s4qjwsdvn1nixxq9h9hficja6nwzd18kkm5";
  };

  buildCommand = ''
    mkdir -p "$out/webapps"
    cp "$src" "$out/webapps/plantuml.war"
  '';

  meta = with stdenv.lib; {
    description = "A web application to generate UML diagrams on-the-fly.";
    homepage = https://plantuml.com/;
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ truh ];
  };
}