#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
log "detaching Zend server from the cluster"
bash "leave_cluster" do
    user "root"
      cwd "/tmp"
      code <<-EOH
          web_api_key=`mysql --skip-column-names -h #{node[:app][:zend_server_mysql_address]} -u#{node[:app][:zend_server_mysql_user]} -p#{node[:app][:zend_server_mysql_password]} ZendServer<<EOFMYSQL
          select HASH from GUI_WEBAPI_KEYS where NAME="zend-zsd";
          EOFMYSQL`
          node_id="$(grep zend_server_daemon.cluster_node_id /usr/local/zend/etc/zsd.ini | cut -d= -f 2 | cut -d@ -f 1)"
          /usr/local/zend/bin/zs-manage cluster-remove-server -N zend-zsd -K $web_api_key -s -r 20 $node_id
      EOH
    end
rightscale_marker :end
