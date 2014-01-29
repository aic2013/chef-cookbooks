git "/home/deploy/batch_commiter" do
  repository "git://github.com/aic2013/batch_commiter.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
  notifies :restart, "service[batch_commiter]"
end

file "/var/log/aic13_batch_commiter.log" do
  owner 'deploy'
  group 'deploy'
  mode "0777"
  action :create
end

template "/home/deploy/batch_commiter/run_batch_commiter.sh" do
  source "run_batch_commiter.sh.erb"
  owner "deploy"
  group "deploy"
  mode 00700
end

template "/etc/init/batch_commiter.conf" do
  source "batch_commiter.conf.erb"
  owner "root"
  group "root"
  mode 00755
end

service "batch_commiter" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end