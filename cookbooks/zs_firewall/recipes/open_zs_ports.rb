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
if node[:sys_firewall][:enabled] == "enabled"
  include_recipe "iptables"
  sys_firewall "10081" # ZS gui HTTP
  sys_firewall "10082" # ZS gui HTTPS
  app_server_rules = {10060=>'tcp',10063=>'tcp',10070=>'udp'} #10060,10063,10070 are ports for Zend session clustering
  app_server_rules.each do |app_port,port_proto|
    sys_firewall "Open this appserver to  port #{app_port} to all Zend Servers" do
      machine_tag "loadbalancer:app=#{node[:lb][:applistener_name]}"
      port app_port
      protocol port_proto
      enable true
      action :update
    end
    sys_firewall "Request all other appservers to open session clustering ports" do
      machine_tag "loadbalancer:app=#{node[:lb][:applistener_name]}"
      port app_port
      protocol port_proto
      enable true
      ip_addr node[:cloud][:private_ips][0]
      action :update_request
    end
  end
end
rs_utils_marker :end
