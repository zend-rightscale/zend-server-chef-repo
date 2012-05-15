maintainer       "Zend Technologies"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Installs/Configures app_php_zend_server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "app"
depends "web_apache"
depends "db_mysql"
depends "db_postgres"
depends "repo"
depends "rs_utils"
 
recipe "app_php::default", "Installs the php application server."
