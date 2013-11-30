git "/home/deploy/webapp" do
  repository "git://github.com/aic2013/webapp.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
end

cookbook_file "/home/deploy/aic13_mmuehlberger_com.crt" do
  owner "deploy"
  group "deploy"
  mode 0600
end

file "/home/deploy/aic13_mmuehlberger_com.key" do
  content node[:webapp][:ssl][:key]
  owner "deploy"
  group "deploy"
  mode 0600
end

template "/etc/init/webapp.conf" do
  source "webapp.conf.erb"
  owner "root"
  group "root"
  mode 00600
end

template "/etc/nginx/sites-enabled/webapp.conf" do
  source "webapp_nginx.conf"
  owner "root"
  group "root"
  mode 00600
  notifies :restart, 'service[nginx]'
end

template "/etc/monit/monitrc" do
  source "webapp_monitrc.erb"
  owner "root"
  group "root"
  mode 00600
end