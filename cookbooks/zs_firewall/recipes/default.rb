#
# Cookbook Name:: zs_firewall
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "Opening firewal ports for Zend Server"
rs_utils_marker :begin

class Chef::Recipe
  include RightScale::App::Helper
  end
if node[:sys_firewall][:enabled] == "enabled"
          include_recipe "iptables"
          sys_firewall "10081" # SSH
          sys_firewall "10082" # HTTP

#  vhosts(node[:lb][:vhost_names]).each do | vhost_name |
#    sys_firewall "Open this appserver's ports to all loadbalancers" do
#        machine_tag "loadbalancer:#{vhost_name}=lb"
#        port node[:app][:port]
#        enable true
#        action :update
#    end
# end

rs_utils_marker :end
