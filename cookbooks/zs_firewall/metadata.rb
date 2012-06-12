maintainer       "Amir Friedman"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Configuration of zs firewall"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5"

recipe "zs_firewall::open_zs_ports","Configuration of clustered Zend server firewall"
recipe "zs_firewall::open_zscm_ports","Basic configuration of Zend Server Cluster Manager firewall"
recipe "zs_firewall::close_zs_ports","closing firewall ports in other ZSs"
recipe "zs_firewall::open_zs_gui_ports","Configuration of Zend server firewall"
depends "sys_firewall"
depends "rs_utils"
