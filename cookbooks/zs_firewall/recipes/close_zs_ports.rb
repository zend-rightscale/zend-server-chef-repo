#
# Cookbook Name:: zs_firewall
# Recipe:: close_zs_ports
#
# Copyright 2012, Zend Technologies 
#
# All rights reserved - Do Not Redistribute
#
log "closing firewal ports for in other Zend servers with the same tag"
rs_utils_marker :begin
if node[:sys_firewall][:enabled] == "enabled"
  include_recipe "iptables"
  app_server_rules = {10060=>'tcp', 10063=>'tcp', 10070 => 'udp'} #10060,10063,10070 are ports for Zend session clustering
  app_server_rules.each do |app_port,port_proto|
    sys_firewall "Request all other appservers to close session clustering ports" do
      machine_tag "appserver:active=true" 
      port app_port
      protocol port_proto
      enable false 
      ip_addr node[:app][:bind_ip] 
      action :update_request
    end
  end
end
rs_utils_marker :end
