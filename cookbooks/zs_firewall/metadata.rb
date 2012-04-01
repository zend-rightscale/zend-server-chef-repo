maintainer       "Amir Friedman"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Configuration of zs firewall"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "zs_firewall::default","Configuration of Zend server firewall"
recipe "zs_firewall::open_zscm_ports","Basic configuration of Zend Server Cluster Manager firewall"
depends "sys_firewall"
depends "rs_utils"

