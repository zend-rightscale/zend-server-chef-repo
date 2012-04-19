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
if node[:sys_firewall_patched][:enabled] == "enabled"
  include_recipe "iptables"
  sys_firewall_patched "10081" # ZS gui HTTP
  sys_firewall_patched "10082" # ZS gui HTTPS
end
rs_utils_marker :end
