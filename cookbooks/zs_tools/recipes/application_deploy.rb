#
# Cookbook Name:: zs_tools
# Recipe:: application_deploy 
#
# Copyright 2012, Zend technologies
#
# All rights reserved - Do Not Redistribute
#
repo "get zpk file from general cloud storage" do 
      destination "/tmp/apps"
      action      ":pull"
end
