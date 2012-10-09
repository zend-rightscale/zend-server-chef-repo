#
# Cookbook Name:: app_php_zend_server
#
# Copyright Zend Technologies, Inc. All rights reserved. 

# Required attributes
#
default[:app][:zend_server_repo_key_url]='http://repos.zend.com/zend.key'
default[:app][:port] = 80
# Recommended attributes
#


# Optional attributes
#
#set_unless[:app][:zend_server_version]="5.6"
#set_unless[:php][:modules_list]=array.new
