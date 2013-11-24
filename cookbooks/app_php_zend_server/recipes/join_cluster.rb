#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
code_to_run = <<-EOH
          /usr/local/zend/bin/zs-manage store-directive -d 'zend_sc.ha.use_broadcast' -v '0' -N #{node[:app_php_zend_server][:api_key_name]} -K #{node[:app_php_zend_server][:api_key]}
          /usr/local/zend/bin/zs-manage store-directive -d 'zend_debugger.allow_hosts' -v '' -N #{node[:app_php_zend_server][:api_key_name]} -K #{node[:app_php_zend_server][:api_key]}
          /usr/local/zend/bin/zs-manage store-directive -d 'zend_gui.extra' -v 'cloud=rightscale' -N #{node[:app_php_zend_server][:api_key_name]} -K #{node[:app_php_zend_server][:api_key]}
          /usr/local/zend/bin/zs-manage server-add-to-cluster -n #{node[:app_php_zend_server][:zend_server_name]} -i #{node[:app_php_zend_server][:zend_server_node_ip]}  -o #{node[:app_php_zend_server][:mysql_address]} -u #{node[:app_php_zend_server][:mysql_user]} -p #{node[:app_php_zend_server][:zend_server_mysql_password]} -d #{node[:app_php_zend_server][:zend_server_mysql_db_name]} -r 60 -w 5 -s -N #{node[:app_php_zend_server][:api_key_name]} -K #{node[:app_php_zend_server][:api_key]}
          EOH
#log "The code to run is: #{code_to_run}"
bash "join_zs_to_cluster" do
      user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
