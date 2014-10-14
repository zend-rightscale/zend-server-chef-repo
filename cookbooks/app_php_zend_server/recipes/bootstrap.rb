#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
log "bootstrap Zend Server"
log "bootstrap Zend server into a single server mode"
bash "pre_bootstrap_zs" do
    user "root"
    cwd "/tmp"
    code <<-EOH
          sleep 120
          /usr/local/zend/bin/zendctl.sh restart 
          sleep 4
          /usr/local/zend/bin/zs-client.sh apiKeysAddKey --name=#{node[:app_php_zend_server][:api_key_name]} --username="admin" --hash #{node[:app_php_zend_server][:api_key]} 
      EOH
end
bs_command = "/usr/local/zend/bin/zs-client.sh bootstrapSingleServer --adminPassword=#{node[:app_php_zend_server][:gui_password]} --production=true --acceptEula --wait "
bs_command << "--orderNumber=#{node[:app_php_zend_server][:order_number]} --licenseKey=#{node[:app_php_zend_server][:zend_license_key]}" unless node[:app_php_zend_server][:order_number].nil? || node[:app_php_zend_server][:order_number].empty? || node[:app_php_zend_server][:zend_license_key].nil? || node[:app_php_zend_server][:zend_license_key].empty?
bash "bootstrap_zs" do
      user "root"
      cwd "/tmp"
      code bs_command 
    end
# Let others know we are an appserver
# See http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/Chef_Resources#RightLinkTag for the "right_link_tag" resource.
    right_link_tag "appserver:active=true"
    right_link_tag "appserver:listen_ip=#{node[:app][:ip]}"
    right_link_tag "appserver:listen_port=#{node[:app][:port]}"

rightscale_marker :end
