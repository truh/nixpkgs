{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "jetty-runner";
  version = "9.4.30.v20200611";
  src = fetchurl {
    url = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/${version}/jetty-runner-${version}.jar";
    sha256 = "05xcslar86lh23picqqma3aw4xfz820razy73g6wm9s85wiva8jk";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p "$out/lib"
    cp "$src" "$out/lib/jetty-runner.jar"
  '';

  meta = {
    description = "Run your webapps without needing an installation of Jetty.";
    homepage = "https://www.eclipse.org/jetty/";
    platforms = stdenv.lib.platforms.all;
    license = [ stdenv.lib.licenses.epl10 ];
  };
}
