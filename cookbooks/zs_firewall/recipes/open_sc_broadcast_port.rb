#
# Cookbook Name:: zs_firewall
# Recipe::open_sc_broadcast_port
#
# Copyright 2012, Zend Technologies 
#
# All rights reserved - Do Not Redistribute
#
log "Opening firewal ports for Zend Server"
rs_utils_marker :begin
    sys_firewall "Request all other appservers to open session clustering ports" do
      machine_tag "loadbalancer:app=#{node[:lb][:applistener_name]}"
      port 10070
      protocol udp
      enable true
      ip_addr node[:cloud][:private_ips][0]
      action :update_request
    end
rs_utils_marker :end
