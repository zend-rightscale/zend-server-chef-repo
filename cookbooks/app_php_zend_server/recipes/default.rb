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
zs_package = "zend-server-php-" + node[:app][:zs_php_ver]
case node[:platform]
when "ubuntu", "debian"
  node[:app][:zend_repo_url]=[node[:app][:zend_repo_base_url] + "/deb"]
   #add Zend server Repo
  apt_repository "zend" do
    uri node[:app][:zend_repo_url].to_s() 
    distribution "server"
    components ["non-free"]
    key node[:app][:zend_server_repo_key_url].to_s()
  end
when "centos","fedora","redhat"
  node[:app][:zend_repo_url]=[node[:app][:zend_repo_base_url] + "/rpm"]
  # add the Zend GPG key
  yum_key "Zend" do
    url node[:app][:zend_server_repo_key_url] 
    action :add
  end
  # add the Zend repositories
  yum_repository "zend_server" do
    description "Zend server repo noarch"
    url (node[:app][:zend_repo_url].to_s() + "noarch")
    key "Zend"
   action :add
  end
  yum_repository "zend_server" do
    description "Zend server repo arch"
    url (node[:app][:zend_repo_url].to_s() + "$basearch")
    key "Zend"
   action :add
  end
end
log "  Setting provider specific settings for php application server."
node[:app][:provider] = "app_php"

# Setting generic app attributes
platform = node[:platform]
case platform
when "ubuntu"
  node[:app][:user] = "www-data"
  node[:app][:group] = "www-data"
when "centos", "redhat"
  node[:app][:user] = "apache"
  node[:app][:group] = "apache"
end
log "  Install Zend Server"
package zs_package do
  action :install
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
# Setting app LWRP attribute
node[:app][:destination] = "#{node[:repo][:default][:destination]}/#{node[:web_apache][:application_name]}"

# PHP shares the same doc root with the application destination
node[:app][:root] = "#{node[:app][:destination]}"

rightscale_marker :end
