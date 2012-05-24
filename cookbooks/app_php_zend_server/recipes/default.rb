#
# Cookbook Name:: app_php_zend_server
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.
# Copyright  Zend technologies Inc. 
rs_utils_marker :begin

log " Setting provider specific settings for Zend server php application server."
node[:app][:packages] = Array.new
if node[:cloud][:private_ips] && node[:cloud][:private_ips].size > 0
          ip = node[:cloud][:private_ips][0] # default to first private ip
        elsif node[:cloud][:public_ips] && node[:cloud][:public_ips].size > 0
          ip = node[:cloud][:public_ips][0] # default to first public ip
        elseif
          raise "ERROR: cannot detect a bind address on this application server."
        end
node[:app][:bind_ip]=ip
rs_utils_marker :end
