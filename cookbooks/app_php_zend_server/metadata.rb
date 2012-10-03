maintainer       "Zend Technologies"
maintainer_email "amir@zend.com"
license          "All rights reserved"
description      "Configures app_php to install Zend Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
#depends "app_php"
recipe "app_php_zend_server::default", "set parameters for ZS install and add installation repositories"
