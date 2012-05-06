maintainer       "Amir Friedman"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Configuration of zs firewall"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5"
recipe "zs_tools::application_deploy","deploy an application to ZS/ZSCM stored on a cloud storage service"
depends "repo"
