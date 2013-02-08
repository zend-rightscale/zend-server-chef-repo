maintainer       "Zend Technologies"
maintainer_email "amir@zend.com"
license          "Copyright Zend Technologies, Inc. All rights reserved."
description      "Installs the php application server Zend Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.0"
depends "rightscale"
depends "app"
depends "repo"
depends "web_apache"
depends "apt"
depends "yum"
recipe "app_php_zend_server::default", "set parameters for ZS install and add installation repositories"
recipe "app_php_zend_server::install", "Install Zend server and configure it as a standalone server"
recipe "app_php_zend_server::join_cluster", "Join the local Zend Server to Cluster of Zend Servers by adding it directly into the MySQL schema"
recipe "app_php_zend_server::leave_cluster", "remove the local server from Zend Server cluster"
attribute "app_php_zend_server",
  :display_name => "PHP Application Settings",
    :type => "hash"
attribute "app_php_zend_server/php_ver",
   :display_name => "php version",
   :description => "php version to install, 5.3 or 5.4",
   :required => "optional",
   :choice => ["5.3", "5.4"],
   :default => "5.4",
   :recipes => ["app_php_zend_server::default"]   
attribute "app_php_zend_server/repo_base_url",
   :display_name => "zend repository base url",
   :description => "zend repository base url is the repository url without the suffix /deb or /rpm",
   :required => "optional",
   :default => "http://repos.zend.com/zend-server/6.0",
   :recipes => ["app_php_zend_server::default"]
attribute "app_php_zend_server/gui_password",
   :display_name => "zend gui password",
   :description => "A string that will be used as the password to Zend Server gui",
   :required => "required",
   :recipes => ["app_php_zend_server::install"]
attribute "app_php_zend_server/order_number",
   :display_name => "Zend Server order number",
   :description => "Zend Server order number should be supplied by Zend or Rightscale coupled with the license key",
   :required => "required",
   :recipes => ["app_php_zend_server::install"]
attribute "app_php_zend_server/zend_license_key",
   :display_name => "Zend server license key ",
   :description => "Zend Server license key should be supplied by Zend or Rightscale coupled with the Zend Server order number",
   :required => "required",
   :recipes => ["app_php_zend_server::install"]
attribute "app_php_zend_server/zend_server_name",
   :display_name => "Zend server name",
   :description => "Zend Server name to identify the server in the gui",
   :required => "required",
   :recipes => ["app_php_zend_server::join_cluster"]
attribute "app_php_zend_server/zend_server_node_ip",
   :display_name => "Zend server node IP",
   :description => "Zend Server IP accessible to other servers in the cluster",
   :required => "required",
   :recipes => ["app_php_zend_server::join_cluster"]
attribute "app_php_zend_server/mysql_address",
   :display_name => "Zend server mysql address",
   :description => "Zend Server mysql DB host address accessible to this server",
   :required => "required",
   :recipes => ["app_php_zend_server::join_cluster","app_php_zend_server::leave_cluster"]
attribute "app_php_zend_server/mysql_user",
   :display_name => "Zend server mysql user name",
   :description => "Zend Server mysql user name that can create the schema and access it",
   :required => "required",
   :recipes => ["app_php_zend_server::join_cluster","app_php_zend_server::leave_cluster"]
attribute "app_php_zend_server/zend_server_mysql_password",
   :display_name => "Zend server mysql password",
   :description => "Zend Server mysql password",
   :required => "required",
   :recipes => ["app_php_zend_server::join_cluster","app_php_zend_server::leave_cluster"]
