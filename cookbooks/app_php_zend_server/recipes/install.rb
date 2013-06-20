#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
log "install Zend Server"
node[:app_php_zend_server][:package_name] = "zend-server-php-" + node[:app_php_zend_server][:php_ver]
package node[:app_php_zend_server][:package_name] do
  action :install
end
rightscale_marker :end
