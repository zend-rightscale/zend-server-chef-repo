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
log "bootstrap Zend server into a single server mode"
bash "bootstrap_zs" do
    user "root"
      cwd "/tmp"
      code <<-EOH
          /usr/local/zend/bin/zendctl.sh restart 
          sleep 4
          /usr/local/zend/bin/zs-manage bootstrap-single-server -p #{node[:app_php_zend_server][:gui_password]} -o  #{node[:app_php_zend_server][:order_number]} -l  #{node[:app_php_zend_server][:zend_license_key]} -a TRUE   -r TRUE || { log "bootstrap failed"; exit 1 ; }
      EOH
    end
rightscale_marker :end
