#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
code_to_run = <<-EOH
          web_api_key=`sqlite3 /usr/local/zend/var/db/gui.db "select HASH from GUI_WEBAPI_KEYS where NAME='zend-zsd';"`
          /usr/local/zend/bin/zs-manage server-add-to-cluster -n #{node[:app_php_zend_server][:zend_server_name]} -i #{node[:app_php_zend_server][:zend_server_node_ip]}  -o #{node[:app_php_zend_server][:mysql_address]} -u #{node[:app_php_zend_server][:mysql_user]} -p #{node[:app_php_zend_server][:zend_server_mysql_password]} -d ZendServer -r 60 -w 5 -s -N zend-zsd -K $web_api_key
          EOH
log "The code to run is: #{code_to_run}"
join_response = bash "join_zs_to_cluster" do
      user "root"
      cwd "/tmp"
      code code_to_run
    end
log "the response from join cluster is #{join_response}"
data = join_response.split(/,/)
node[:app_php_zend_server][:node_id] = data[0].split(/:/)[1].strip
node[:app_php_zend_server][:api_user]= data[2].split(/:/)[1].strip
node[:app_php_zend_server][:api_key]=  data[3].split(/:/)[1].strip
bash "change sc to cloud mode" do
      user "root"
      cwd "/tmp"
      code <<-EOH 
          /usr/local/zend/bin/zs-manage store-directive -d 'zend_sc.ha.use_broadcast' -v '0' -N #{node[:app_php_zend_server][:api_user]} -K #{node[:app_php_zend_server][:api_key]}"
          EOH
    end
rightscale_marker :end
