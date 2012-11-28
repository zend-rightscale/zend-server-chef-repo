#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
code_to_run = <<-EOH
          web_api_key=`sqlite3 /usr/local/zend/var/db/gui.db "select HASH from GUI_WEBAPI_KEYS where NAME='zend-zsd';"`
          #if nc -zv -w120 $HOSTIP 22 <<< ” &> /dev/null
          #then
          #          log 'MySQL Port is open'
                    /usr/local/zend/bin/zs-manage server-add-to-cluster -n #{node[:app_php_zend_server][:zend_server_name]} -i #{node[:app_php_zend_server][:zend_server_node_ip]}  -o #{node[:app_php_zend_server][:mysql_address]} -u #{node[:app_php_zend_server][:mysql_user]} -p #{node[:app_php_zend_server][:mysql_password]} -d ZendServer -N zend-zsd -K $web_api_key
          #else
          #          log 'MySQL Port is closed'
          #          exit 1
          #fi
          EOH
log "The code to run is: #{code_to_run}"
bash "join_zs_to_cluster" do
      user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
