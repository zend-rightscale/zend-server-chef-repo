#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log " Setting provider specific settings for Zend server php application server."
# prevent app_php::default from installing the RS php
node[:app][:packages] = Array.new
node[:app][:packages] = ["zend-server-php" + node[:app][:zs_php_ver]]
# Remove RS mod php enable in Ubuntu apache
case node[:platform]
when "ubuntu", "debian"
  node[:app][:zend_repo_url]=[node[:app][:zend_repo_base_url] + "/deb"]
   #add Zend server Repo
  apt_repository "ZendServer" do
    uri node[:app][:zend_repo_url].to_s() 
    distribution "server"
    components ["non-free"]
    key node[:app][:zend_server_repo_key_url]
  end
  node[:php][:module_dependencies] = Array.new(1,"proxy_http")
when "centos","fedora","redhat"
  node[:app][:zend_repo_url]=[node[:app][:zend_repo_base_url] + "/rpm"]
  # add the Zend GPG key
  yum_key "Zend" do
    url node[:app][:zend_server_repo_key_url] 
    action :add
  end
  # add the Zennd repository
  yum_repository "zend_server" do
    description "Zend server repo"
    url node[:app][:zend_repo_url]
    key "Zend"
   action :add
  end
end
#Set the right IP for use in firewall rules
if node[:cloud][:private_ips] && node[:cloud][:private_ips].size > 0
  ip = node[:cloud][:private_ips][0] # default to first private ip
elsif node[:cloud][:public_ips] && node[:cloud][:public_ips].size > 0
  ip = node[:cloud][:public_ips][0] # default to first public ip
else
  raise "ERROR: cannot detect a bind address on this application server."
end
node[:app][:bind_ip] = ip
#node[:app][:port] = 80
rightscale_marker :end
