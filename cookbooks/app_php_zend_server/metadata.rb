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
recipe "app_php_zend_server::install", "Install Zend server on Apache webserver"
recipe "app_php_zend_server::install_nginx", "Install Zend server on Nginx webserver"
recipe "app_php_zend_server::bootstrap", "Bootstrap Zend Server into single server mode and tag as an app server"
recipe "app_php_zend_server::join_cluster", "Join the local Zend Server to Cluster of Zend Servers by adding it directly into the MySQL schema"
recipe "app_php_zend_server::leave_cluster", "remove the local server from Zend Server cluster"
recipe "app_php_zend_server::change_decommission_timeout", "change the rightlink decomission timeout"
attribute "app_php_zend_server",
  :display_name => "PHP Application Settings",
    :type => "hash"
attribute "app_php_zend_server/php_ver",
   :display_name => "php version",
   :description => "php version to install, 5.3 or 5.4",
   :required => "optional",
   :choice => ["5.3", "5.4"],
   :default => "5.4",
   :recipes => ["app_php_zend_server::install","app_php_zend_server::install_nginx"]   
attribute "app_php_zend_server/repo_base_url",
   :display_name => "zend repository base url",
   :description => "zend repository base url is the repository url without the suffix /deb or /rpm",
   :required => "optional",
   :default => "http://repos.zend.com/zend-server/6.2",
   :recipes => ["app_php_zend_server::default"]
attribute "app_php_zend_server/gui_password",
   :display_name => "zend gui password",
   :description => "A string that will be used as the password to Zend Server gui",
   :required => "required",
   :recipes => ["app_php_zend_server::bootstrap"]
attribute "app_php_zend_server/api_key",
   :display_name => "zend api key hash",
   :description => "64 chars string that will be used as the webapi key hash to access Zend Server through webapi",
   :required => "required",
   :recipes => ["app_php_zend_server::bootstrap","app_php_zend_server::leave_cluster","app_php_zend_server::join_cluster"]
attribute "app_php_zend_server/api_key_name",
   :display_name => "zend api key name",
   :description => "web api key name",
   :required => "optional",
   :default => "rightscale",
   :recipes => ["app_php_zend_server::bootstrap","app_php_zend_server::leave_cluster","app_php_zend_server::join_cluster"]
attribute "app_php_zend_server/order_number",
   :display_name => "Zend Server order number",
   :description => "Zend Server order number should be supplied by Zend or Rightscale coupled with the license key",
   :required => "optional",
   :recipes => ["app_php_zend_server::bootstrap"]
attribute "app_php_zend_server/zend_license_key",
   :display_name => "Zend server license key ",
   :description => "Zend Server license key should be supplied by Zend or Rightscale coupled with the Zend Server order number",
   :required => "optional",
   :recipes => ["app_php_zend_server::bootstrap"]
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
attribute "app_php_zend_server/decommission_timeout",
          :display_name => "decommission timeout", 
          :description => "Decommission timeout of the server before booting. Change is needed to enable session clustering longer transfer time",
          :required => "optional",
          :default => "180",
          :recipes => ["app_php_zend_server::change_decommission_timeout"]
