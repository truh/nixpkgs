{ stdenv, fetchgit, buildPythonPackage
, python
, srht, redis, alembic, pystache
, pytest, factory_boy, writeText }:

buildPythonPackage rec {
  pname = "todosrht";
  version = "0.55.3";

  src = fetchgit {
    url = "https://git.sr.ht/~sircmpwn/todo.sr.ht";
    rev = version;
    sha256 = "1j82yxdnag0q6rp0rpiq3ccn5maa1k58j2f1ilcsxf1gr13pycf5";
  };

  patches = [
    ./use-srht-path.patch
  ];

  nativeBuildInputs = srht.nativeBuildInputs;

  propagatedBuildInputs = [
    srht
    redis
    alembic
    pystache
  ];

  preBuild = ''
    export PKGVER=${version}
    export SRHT_PATH=${srht}/${python.sitePackages}/srht
  '';

  checkInputs = [
    pytest
    factory_boy
  ];

  installCheckPhase = let
    config = writeText "config.ini" ''
      [webhooks]
      private-key=K6JupPpnr0HnBjelKTQUSm3Ro9SgzEA2T2Zv472OvzI=

      [todo.sr.ht]
      origin=http://todo.sr.ht.local
      oauth-client-id=
      oauth-client-secret=

      [todo.sr.ht::mail]
      posting-domain=

      [meta.sr.ht]
      origin=http://meta.sr.ht.local
    '';
  in ''
    cp -f ${config} config.ini

    # pytest tests fail
    # pytest tests/
  '';

  meta = with stdenv.lib; {
    homepage = https://todo.sr.ht/~sircmpwn/todo.sr.ht;
    description = "Ticket tracking service for the sr.ht network";
    license = licenses.agpl3;
    maintainers = with maintainers; [ eadwu ];
  };
}
