#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "Install and bootstrap Zend server into a single server mode"
zs_package = "zend-server-php-" + node[:app][:zs_php_ver]
package zs_package do
  action :install
end
code_to_run= <<-EOH
          sed "s|^zend_server_daemon.log_verbosity_level\s*=.*|zend_server_daemon.log_verbosity_level=3|g" -i /usr/local/zend/etc/zsd.ini
          sed "s|^zend_sc.ha.use_broadcast\s*=.*|zend_sc.ha.use_broadcast=0|g" -i /usr/local/zend/etc/scd.ini
          /usr/local/zend/bin/zs-manage bootstrap-single-server -p #{node[:app][:zend_gui_password]} -d 1234 -o  #{node[:app][:zend_order_number]} -l  #{node[:app][:zend_license_key]} -a TRUE   -r TRUE
          /usr/local/zend/bin/zendctl.sh restart
      EOH
#log "Bootstrap code: #{code_to_run}"
bash "bootstrap_zs" do
    user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
