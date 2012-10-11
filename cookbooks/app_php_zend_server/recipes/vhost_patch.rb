#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rs_utils_marker :begin

node[:app][:port] = 80
node[:app][:destination] = "#{node[:repo][:default][:destination]}/#{node[:web_apache][:application_name]}"
case node[:platform]
when "ubuntu", "debian"
  vhost_conf_file = "/etc/apache2/sites-enabled/myapp.conf"   
when "centos","fedora","redhat"
  vhost_conf_file = "/etc/httpd/sites-enabled/myapp.conf"
end
bash "fix_vhost_file" do
  user "root"
  cwd "/tmp"
  code <<-EOH
        vhost_conf_file="#{vhost_conf_file}"
        docroot="#{node[:app][:destination]}"
        sed "s|DocumentRoot|DocumentRoot \"$docroot\" |g" -i  $vhost_conf_file
        sed "s|<Directory >|<Directory \"$docroot\"> |g" -i  $vhost_conf_file
  EOH
    end
rs_utils_marker :end
