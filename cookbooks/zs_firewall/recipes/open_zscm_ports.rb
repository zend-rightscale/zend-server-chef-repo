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
  sys_firewall 80 do
    protocol tcp
    enable false
    action :update
  end
  sys_firewall 443 do
    protocol tcp
    enable false
    action :update
  end

end
right_link_tag "zscm:active=true"
rs_utils_marker :end
