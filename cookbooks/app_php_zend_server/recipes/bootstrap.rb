#
# Cookbook Name:: app_php_zend_server
#
# Copyright  Zend technologies Inc. 
rightscale_marker :begin
log "bootstrap Zend Server"
log "bootstrap Zend server into a single server mode"
bash "pre_bootstrap_zs" do
    user "root"
    cwd "/tmp"
    code <<-EOH
          /usr/local/zend/bin/zendctl.sh restart 
          sleep 4
          /usr/local/zend/bin/zs-manage api-keys-add-key -n #{node[:app_php_zend_server][:api_key_name]} -s #{node[:app_php_zend_server][:api_key]} 
          sed "s|^zend_gui.extra\s*=.*|zend_gui.extra = \"cloud=RightScale\&templateVersion=6.2.0\"|" -i /usr/local/zend/gui/config/zs_ui.ini
      EOH
end
if node[:app_php_zend_server][:order_number].empty or node[:app_php_zend_server][:zend_license_key].empty then
    bootstrap =<<-EOH
    /usr/local/zend/bin/zs-manage bootstrap-single-server -p #{node[:app_php_zend_server][:gui_password]} -a TRUE   -r TRUE || { log "bootstrap failed"; exit 1 ; }
    EOH
else
    bootstrap =<<-EOH
    /usr/local/zend/bin/zs-manage bootstrap-single-server -p #{node[:app_php_zend_server][:gui_password]} -o  #{node[:app_php_zend_server][:order_number]} -l  #{node[:app_php_zend_server][:zend_license_key]} -a TRUE   -r TRUE || { log "bootstrap failed"; exit 1 ; }
    EOH
end
bash "bootstrap_zs" do
      user "root"
      cwd "/tmp"
      code bootstrap
    end
# Let others know we are an appserver
# See http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/Chef_Resources#RightLinkTag for the "right_link_tag" resource.
    right_link_tag "appserver:active=true"
    right_link_tag "appserver:listen_ip=#{node[:app][:ip]}"
    right_link_tag "appserver:listen_port=#{node[:app][:port]}"

rightscale_marker :end
