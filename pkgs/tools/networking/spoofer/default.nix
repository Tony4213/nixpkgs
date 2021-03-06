{ stdenv, fetchurl, pkgconfig, protobuf, openssl, libpcap, traceroute
, withGUI ? false, qt5 }:

let inherit (stdenv.lib) optional;
in

stdenv.mkDerivation rec {
  pname = "spoofer";
  version = "1.4.5";

  src = fetchurl {
    url = "https://www.caida.org/projects/spoofer/downloads/${pname}-${version}.tar.gz";
    sha256 = "0pnim3xyfsmv6alsvhwjs4v9lp39wwiyj63rxsqyz4wx4vkmn12z";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl protobuf libpcap traceroute ]
                ++ optional withGUI qt5.qtbase ;

  meta = with stdenv.lib; {
    homepage = "https://www.caida.org/projects/spoofer";
    description = "Assess and report on deployment of source address validation";
    longDescription = ''
      Spoofer is a new client-server system for Windows, MacOS, and
      UNIX-like systems that periodically tests a network's ability to
      both send and receive packets with forged source IP addresses
      (spoofed packets). This can be used to produce reports and
      visualizations to inform operators, response teams, and policy
      analysts. The system measures different types of forged
      addresses, including private and neighboring addresses.  The
      test results allows to analyze characteristics of networks
      deploying source address validation (e.g., network location,
      business type).
    '';
    platforms = platforms.all;
    license = licenses.gpl3Plus;
    maintainers = with stdenv.lib.maintainers; [ leenaars];
  };
}
