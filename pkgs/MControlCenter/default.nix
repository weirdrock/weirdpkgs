{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  qtbase,
  wrapQtAppsHook,
  qttools,
}:
stdenv.mkDerivation rec {
  pname = "mcontrolcenter";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "dmitry-s93";
    repo = pname;
    rev = version;
    sha256 = "sha256-SV78OVRGzy2zFLT3xqeUtbjlh81Z97PVao18P3h/8dI=";
  };

  buildInputs = [
    qtbase
    qttools
  ];
  nativeBuildInputs = [
    wrapQtAppsHook
    cmake
  ];

  postInstall = ''
    install -Dm644 $src/src/helper/mcontrolcenter-helper.conf $out/share/system.d/mcontrolcenter-helper.conf
    install -Dm644 $src/src/helper/mcontrolcenter.helper.service $out/share/system-services/mcontrolcenter.helper.service

    sed -i -e 's,/usr/libexec/mcontrolcenter-helper,mcontrolcenter-helper,g' $out/share/system-services/mcontrolcenter.helper.service

    install -Dm644 $src/resources/mcontrolcenter.svg $out/share/icons/hicolor/scalable/apps/mcontrolcenter.svg
    install -Dm644 $src/resources/mcontrolcenter.desktop $out/share/applications/mcontrolcenter.desktop
    install -Dm644 $src/resources/mcontrolcenter.appdata.xml $out/share/metainfo/mcontrolcenter.appdata.xml
  '';

  meta = with lib; {
    description = "An application that allows you to change the settings of MSI laptops running Linux";
    homepage = "https://github.com/dmitry-s93/MControlCenter";
    license = licenses.gpl3;
  };
}
