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
if node[:sys_firewall_patched][:enabled] == "enabled"
  include_recipe "iptables"
  app_server_rules = {10060=>'tcp', 10063=>'tcp', 10070 => 'udp'} #10060,10063,10070 are ports for Zend session clustering
  app_server_rules.each do |app_port,port_proto|
    sys_firewall_patched "Request all other appservers to open session clustering ports" do
      machine_tag "loadbalancer:app=#{node[:lb][:applistener_name]}"
      port app_port
      protocol port_proto
      enable false 
      ip_addr node[:cloud][:private_ips][0]
      action :update_request
    end
  end
end
rs_utils_marker :end
