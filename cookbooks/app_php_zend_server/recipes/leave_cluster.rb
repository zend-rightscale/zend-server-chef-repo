#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
code_to_run = <<-EOH
          web_api_key=`mysql --skip-column-names -h 10.198.89.155 -uadminuser -ppassword ZendServer << EOF
          select HASH from GUI_WEBAPI_KEYS where NAME="zend-zsd";
EOF
`
          node_id="$(grep zend_server_daemon.cluster_node_id /usr/local/zend/etc/zsd.ini | cut -d= -f 2 | cut -d@ -f 1)"
          /usr/local/zend/bin/zs-manage cluster-remove-server -N zend-zsd -K $web_api_key $web_api_key
      EOH
log "detaching Zend server from the cluster with command: #{code_to_run}"
bash "leave_cluster" do
    user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
