maintainer       "Amir Friedman"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Configuration of zs firewall"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "zs_firewall::open_zs_ports","Configuration of Zend server firewall"
recipe "zs_firewall::open_sc_broadcast_port","open 10070 udp port as a workaround"
recipe "zs_firewall::open_zscm_ports","Basic configuration of Zend Server Cluster Manager firewall"
recipe "zs_firewall::close_zs_ports","closing the other Zend servers firewall for the server"
depends "sys_firewall"
depends "rs_utils"

