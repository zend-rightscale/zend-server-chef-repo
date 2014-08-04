#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
code_to_run = <<-EOH
          node_id="$(grep zend_server_daemon.cluster_node_id /usr/local/zend/etc/zsd.ini | cut -d= -f 2 | cut -d@ -f 1)"
#          /usr/local/zend/bin/zs-manage cluster-remove-server -N #{node[:app_php_zend_server][:api_key_name]} -K #{node[:app_php_zend_server][:api_key]} -s $node_id
/usr/local/zend/bin/zs-client.sh clusterRemoveServer --zskey=#{node[:app_php_zend_server][:api_key_name]} --zssecret=#{node[:app_php_zend_server][:api_key]} --serverId=$node_id --wait
      EOH
log "detaching Zend server from the cluster with command: #{code_to_run}"
bash "leave_cluster" do
    user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
