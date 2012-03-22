#
# Cookbook Name:: zs_firewall
# Recipe:: default
#
# Copyright 2012, Zend Technologies 
#
# All rights reserved - Do Not Redistribute
#
log "Opening firewal ports for Zend Server"
rs_utils_marker :begin

#class Chef::Recipe
#  include RightScale::App::Helper
#  end
if node[:sys_firewall][:enabled] == "enabled"
          include_recipe "iptables"
          sys_firewall "10081" # ZS gui HTTP
          sys_firewall "10082" # ZS gui HTTPS
end

r=rs_utils_server_collection 'app_servers' do
   action :nothing
end
log "trying to print the servers"
#log "r #{r}"
#log "and p r #{p r}"
File::open( '/tmp/data-nodes.txt', 'w' ) do |f|
  f = node.each do |key,value|
    "key #{key} \n value #{value}"
  end 
end
File::open( '/tmp/data-servcol.txt', 'w' ) do |f|
     f <<  r
  end 

#  vhosts(node[:lb][:vhost_names]).each do | vhost_name |
#    sys_firewall "Open this appserver's ports to all loadbalancers" do
#        machine_tag "loadbalancer:#{vhost_name}=lb"
#        port node[:app][:port]
#        enable true
#        action :update
#    end
# end

rs_utils_marker :end
