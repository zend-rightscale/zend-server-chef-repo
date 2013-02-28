#
# Cookbook Name:: app_php_zend_server
#
# Copyright Zend technologies Inc.
rightscale_marker :begin
unless node[:app_php_zend_server][:decommission_timeout] == "default"
  log "change rightlink decommission timeout to #{node[:app_php_zend_server][:decommission_timeout]}"
  template "/tmp/change_decommission.sh" do
    source "change_decommission.erb"
    variables({
      :decommission_timeout => node[:app_php_zend_server][:decommission_timeout]
    })
  end
  bash "change_decommission_timeout" do
      user "root"
      cwd "/tmp"
      code <<-EOH
      at now + 2 minutes -f /tmp/change_decommission.sh
      EOH
  end
else 
 log "Not changing the default decommission value"
end

rightscale_marker :end
