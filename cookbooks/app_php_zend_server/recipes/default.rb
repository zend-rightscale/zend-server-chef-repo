#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rs_utils_marker :begin

log " Setting provider specific settings for Zend server php application server."
node[:app][:zend_server_version] = "5.6"
node[:app][:zend_server_php_version]="5.3"
node[:app][:provider] = "app_php_zend_server"
node[:app][:destination]="#{node[:web_apache][:docroot]}"
node[:app][:packages] = ["zend-server-php-" + node[:app][:zend_server_php_version]]
node[:app][:zend_server_repo_baseurl]="http://repos.zend.com/zend-server/"
node[:app][:zend_server_repo_suffix]="5.6"
#node[:app][:zend_server_repo_url]=node[:app][:zend_server_repo_baseurl]+node[:app][:zend_server_repo_suffix]
url=node[:app][:zend_server_repo_baseurl]+node[:app][:zend_server_repo_suffix] 
case node[:platform]
when "ubuntu", "debian"
  template "/etc/apt/sources.list.d/zend.list" do
    source "zend.list.erb"
  end
execute "curl -s http://repos.zend.com/zend.key | apt-key add -" do
  action :nothing
end
execute "apt-get update" do
  action :nothing
end
when "centos", "redhat"
yum_repository "zend" do
  description "Zend Server Repo"
  key node['repo']['zend']['http://repos.zend.com/zend.key']
  url node['repo']['zend']['http://repos.zend.com/zend-server/5.6']
  mirrorlist true
  action :add
  enabled 0
end
#  template "/etc/yum.repos.d/zend.repo" do
#    source "zend.repo.erb"
#  end
else
  raise "Unrecognized distro #{node[:platform]}, exiting "
end
rs_utils_marker :end




