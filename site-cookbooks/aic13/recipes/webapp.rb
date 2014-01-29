git "/home/deploy/webapp" do
  repository "git://github.com/aic2013/frontend.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
end

cookbook_file "/home/deploy/aic13_mmuehlberger_com.crt" do
  owner "deploy"
  group "deploy"
  mode 0600
  notifies :restart, 'service[nginx]'
end

file "/home/deploy/aic13_mmuehlberger_com.key" do
  content node[:webapp][:ssl][:key]
  owner "deploy"
  group "deploy"
  mode 0600
  notifies :restart, 'service[nginx]'
end

template "/etc/nginx/sites-enabled/webapp.conf" do
  source "webapp_nginx.conf"
  owner "root"
  group "root"
  mode 00600
  notifies :restart, 'service[nginx]'
end

template "/etc/nginx/sites-enabled/api.conf" do
  source "api_nginx.conf"
  owner "root"
  group "root"
  mode 00600
  notifies :restart, 'service[nginx]'
end

template "/etc/init.d/unicorn_api.sh" do
  source "unicorn_api.sh.erb"
  owner "root"
  group "root"
  mode 00600
end