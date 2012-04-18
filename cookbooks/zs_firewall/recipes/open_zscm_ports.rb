#
# Cookbook Name:: zs_firewall
# Recipe:: open_zscm_ports
#
# Copyright 2012, Zend Technologies 
#
# All rights reserved - Do Not Redistribute
#
log "Opening firewal ports for Zend Server cluster manager"
rs_utils_marker :begin
if node[:sys_firewall][:enabled] == "enabled"
  include_recipe "iptables"
  sys_firewall "10081" # ZS gui HTTP
  sys_firewall "10082" # ZS gui HTTPS
end
rs_utils_marker :end
