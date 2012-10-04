#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "bootstrap Zend server into a single server mode"
bash "bootstrap_zs" do
    user "root"
      cwd "/tmp"
      code <<-EOH
          sed "s|^zend_sc.ha.use_broadcast\s*=.*|zend_sc.ha.use_broadcast=0|g" -i /usr/local/zend/etc/scd.ini
          /usr/local/zend/bin/zs-manage bootstrap-single-server -p #{[node[:app][:zend_gui_password]} -o  #{[node[:app][:zend_order_number]} -l  #{[node[:app][:zend_license_key]} -a TRUE   -r TRUE
          /usr/local/zend/bin/zendctl.sh restart
      EOH
    end
rightscale_marker :end
