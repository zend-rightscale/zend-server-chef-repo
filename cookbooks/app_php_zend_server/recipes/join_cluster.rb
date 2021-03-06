#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
code_to_run = <<-EOH
          #set -e
          web_api_key=`sqlite3 /usr/local/zend/var/db/gui.db "select HASH from GUI_WEBAPI_KEYS where NAME='zend-zsd';"`
          /usr/local/zend/bin/zs-manage server-add-to-cluster -n #{node[:app][:zend_server_name]} -i #{node[:app][:zend_server_node_ip]}  -o #{node[:app][:zend_server_mysql_address]} -u #{node[:app][:zend_server_mysql_user]} -p #{node[:app][:zend_server_mysql_password]} -d ZendServer -N zend-zsd -K $web_api_key
          exit 0
          EOH
log "The code to run is: #{code_to_run}"
bash "join_zs_to_cluster" do
      user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
