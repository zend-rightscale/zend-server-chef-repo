#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rs_utils_marker :begin

log " Setting provider specific settings for Zend server php application server."

node[:app][:provider] = "app_php_zend_server"
node[:app][:destination]="#{node[:web_apache][:docroot]}"
node[:app][:packages] = ["php5", "php5-mysql", "php-pear", "libapache2-mod-php5"]

rs_utils_marker :end




