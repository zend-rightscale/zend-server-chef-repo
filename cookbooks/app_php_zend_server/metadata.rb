maintainer       "Zend Technologies"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Installs/Configures app_php_zend_server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "app"
#depends "web_apache"
#depends "db_mysql"
#depends "repo"
#depends "rs_utils"

recipe "app_php_zend_server::default", "remove php packages from packages to install"
recipe "app_php_zend_server::vhost_patch", "Patch to fix vhost problem when changing vhost name"
