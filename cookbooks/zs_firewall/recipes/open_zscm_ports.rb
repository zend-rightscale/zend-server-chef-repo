#
# Cookbook Name:: zs_firewall
# Recipe:: open_zscm_ports
#
# Copyright 2012, Zend Technologies 
#
# All rights reserved - Do Not Redistribute
#
log "Opening firewal ports for Zend Server cluster manager"
rightscale_marker :begin
if node[:cloud][:private_ips] && node[:cloud][:private_ips].size > 0
  ip = node[:cloud][:private_ips][0] # default to first private ip
elsif node[:cloud][:public_ips] && node[:cloud][:public_ips].size > 0
  ip = node[:cloud][:public_ips][0] # default to first public ip
else
  raise "ERROR: cannot detect a bind address on this application server."
end
if node[:sys_firewall][:enabled] == "enabled"
  include_recipe "iptables"
  sys_firewall "10081" # ZS gui HTTP
  sys_firewall "10082" # ZS gui HTTPS
  zscm_rules = {10081=>'tcp',10082=>'udp'} 
  zscm_rules.each do |app_port,port_proto|
    sys_firewall "Request all other appservers to open gui ports to zscm" do
      machine_tag "appserver:active=true"
      port app_port
      protocol port_proto
      enable true
      ip_addr ip
      action :update_request
    end
  end
  sys_firewall '80' do
    protocol 'tcp'
    enable false
    action :update
  end
  sys_firewall '443' do
    protocol 'tcp'
    enable false
    action :update
  end

end
right_link_tag "appserver:zscm=true"
rightscale_marker :end
