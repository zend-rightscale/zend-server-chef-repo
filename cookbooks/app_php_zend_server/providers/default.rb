#
# Cookbook Name:: app_php_zend_server
#

# Stop Zend Server
action :stop do
  log "  Running stop sequence"
  service "zend-server" do
    action :start
    persist false
  end
end

# Start Zend Server
action :start do
  log "  Running start sequence"
  service "zend-server" do
    action :start
    persist false
  end
end

# Reload apache
#action :reload do
#  log "  Running reload sequence"
#  service "apache2" do
#    action :reload
#    persist false
#  end
#end

# Restart apache
action :restart do
  action_stop
  sleep 5
  action_start
end

action :install do

log "Installing php after app default and setvhost recipes ran. Zend Server needs the default vhost in place when installed"

end

# Setup apache PHP virtual host
action :setup_vhost do

  project_root = new_resource.root
  php_port = new_resource.port

  # Disable default vhost
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_site.rb for the "apache_site" definition.
  apache_site "000-default" do
    enable false
  end

  # Adds php port to list of ports for webserver to listen on
  # See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
  app_add_listen_port php_port

  # Configure apache vhost for PHP
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/web_app.rb for the "web_app" definition.
  web_app node[:web_apache][:application_name] do
    template "app_server.erb"
    docroot project_root
    vhost_port php_port.to_s
    server_name node[:web_apache][:server_name]
    allow_override node[:web_apache][:allow_override]
    cookbook "app_php"
  end

end


action :setup_monitoring do

  log "  Monitoring resource is not implemented in php framework yet. Use apache monitoring instead."

end
