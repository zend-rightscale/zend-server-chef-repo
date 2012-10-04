#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
bash "join_zs_to_cluster" do
    user "root"
      cwd "/tmp"
      code <<-EOH
          web_api_key=`sqlite3 /usr/local/zend/var/db/gui.db "select HASH from GUI_WEBAPI_KEYS where NAME='zend-zsd';"`
          /usr/local/zend/bin/zs-manage server-add-to-cluster -n #{[node[:app][:zend_server_name]} -i #{[node[:app][:zend_server_node_ip]}  -o #{[node[:app][:zend_server_mysql_address]} -u #{[node[:app][:zend_server_mysql_user]} -p #{[node[:app][:zend_server_mysql_password]} -d ZendServer -N zend-zsd -K $web_api_key
      EOH
    end
rightscale_marker :end
