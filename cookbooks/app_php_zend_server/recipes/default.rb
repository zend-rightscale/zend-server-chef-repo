#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rightscale_marker :begin

log " Setting provider specific settings for Zend server php application server."
node[:app][:provider] = "app_php_zend_server"

case node[:platform]
when "ubuntu", "debian"
  node[:app][:user] = "www-data"
  node[:app][:group] = "www-data"
  node[:app_php_zend_server][:zend_repo_url]=node[:app_php_zend_server][:repo_base_url] + "/deb_ssl1.0"
   #add Zend server Repo
  apt_repository "zend" do
    uri node[:app_php_zend_server][:zend_repo_url] 
    distribution "server"
    components ["non-free"]
    key node[:app_php_zend_server][:repo_key_url].to_s()
  end
when "centos","fedora","redhat"
  node[:app][:user] = "apache"
  node[:app][:group] = "apache"
  node[:app_php_zend_server][:zend_repo_url]=node[:app_php_zend_server][:repo_base_url] + "/rpm"
  # add the Zend GPG key
  yum_key "Zend" do
    url node[:app_php_zend_server][:repo_key_url].to_s()
    action :add
  end
  # add the Zend repositories
  yum_repository "zend_noarch" do
    description "Zend server repo noarch"
    url (node[:app_php_zend_server][:zend_repo_url] + "/noarch")
    key "Zend"
   action :add
  end
  yum_repository "zend_arch" do
    description "Zend server repo arch specific"
    url (node[:app_php_zend_server][:zend_repo_url] + "/$basearch")
    key "Zend"
   action :add
  end
end

#From app_php::install recipe
# Set ip address that the application service is listening on.
# If instance has no public ip's first private ip will be used.
# User will be notified.
public_ip = node[:cloud][:public_ips][0]
private_ip = node[:cloud][:private_ips][0]
# See cookbooks/rightscale/libraries/helper.rb for the "is_valid_ip?" method.
if RightScale::Utils::Helper.is_valid_ip?(public_ip)
  node[:app][:backend_ip_type] == "Public" ? node[:app][:ip] = public_ip : node[:app][:ip] = private_ip
elsif RightScale::Utils::Helper.is_valid_ip?(private_ip)
  log "  No public IP detected. Forcing to first private: #{private_ip}"
  node[:app][:ip] = private_ip
else
  raise "No valid public/private IP found for the server."
end


# Setting app LWRP attribute
node[:app][:destination] = "#{node[:repo][:default][:destination]}/#{node[:web_apache][:application_name]}"

directory "#{node[:app][:destination]}" do
  recursive true
end

node[:app][:root]= node[:app][:destination]

log "  Provider is #{node[:app][:provider]}"
log "  Application IP is #{node[:app][:ip]}"
log "  Application port is #{node[:app][:port]}"
log "  Application root is #{node[:app][:root]}"

rightscale_marker :end
