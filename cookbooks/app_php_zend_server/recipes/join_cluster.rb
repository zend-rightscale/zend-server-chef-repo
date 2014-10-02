#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log "join local Zend server to cluster"
code_to_run = <<-EOH
          zs_db_exist="`mysql -u"#{node[:app_php_zend_server][:mysql_user]}" -p"#{node[:app_php_zend_server][:zend_server_mysql_password]}" -h "#{node[:app_php_zend_server][:mysql_address]}" -qfsBe "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME=#{node[:app_php_zend_server][:zend_server_mysql_db_name]}" 2>&1`"
          echo $zs_db_exist
          set +e
          n=0
          until [ $n -ge 13 ]
          do
                    /usr/local/zend/bin/zs-client.sh configurationStoreDirectives --zskey=#{node[:app_php_zend_server][:api_key_name]} --zssecret=#{node[:app_php_zend_server][:api_key]} --directives="zend_sc.ha.use_broadcast=0&zend_debugger.allow_hosts=''"
                    /usr/local/zend/bin/zs-client.sh serverAddToCluster --zskey=#{node[:app_php_zend_server][:api_key_name]} --zssecret=#{node[:app_php_zend_server][:api_key]} --serverName=#{node[:app_php_zend_server][:zend_server_name]} --nodeIp=#{node[:app_php_zend_server][:zend_server_node_ip]} --dbHost=#{node[:app_php_zend_server][:mysql_address]} --dbUsername=#{node[:app_php_zend_server][:mysql_user]} --dbPassword=#{node[:app_php_zend_server][:zend_server_mysql_password]} --dbName=#{node[:app_php_zend_server][:zend_server_mysql_db_name]} --wait
                    [ $? -eq 0 ] && break
                    echo "Bootstrap iteration $n failed"
                    n=$[$n+1]
                    sleep 3
          done
          EOH
log "The join cluster code is: #{code_to_run}"
bash "join_zs_to_cluster" do
      user "root"
      cwd "/tmp"
      code code_to_run
    end
rightscale_marker :end
