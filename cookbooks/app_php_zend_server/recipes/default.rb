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
  apt_repository "nginx" do
    uri "http://nginx.org/packages/ubuntu/"
    distribution "lucid"
    components ["nginx"]
    key "http://nginx.org/keys/nginx_signing.key"
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
  yum_key "nginx" do
    url "http://nginx.org/keys/nginx_signing.key"
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
  yum_repository "nginx_repo" do
    description "nginx_repo"
    url ("http://nginx.org/packages/OS/OSRELEASE/$basearch/")
    key "nginx"
   action :add
  end
end



log "  Provider is #{node[:app][:provider]}"
log "  Application IP is #{node[:app][:ip]}"
log "  Application port is #{node[:app][:port]}"
#log "  Application root is #{node[:app][:root]}"

rightscale_marker :end
