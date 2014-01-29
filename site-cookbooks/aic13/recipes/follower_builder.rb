git "/home/deploy/follower_builder" do
  repository "git://github.com/aic2013/FollowerBuilder.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
  notifies :restart, "service[follower_builder]"
end

file "/var/log/aic13_follower_builder.log" do
  owner 'deploy'
  group 'deploy'
  mode "0777"
  action :create
end

template "/home/deploy/follower_builder/run_follower_builder.sh" do
  source "run_follower_builder.sh.erb"
  owner "deploy"
  group "deploy"
  mode 00700
end

template "/home/deploy/follower_builder/hibernate.properties" do
  source "hibernate.properties.erb"
  owner "deploy"
  group "deploy"
  mode 00600
end

template "/etc/init/follower_builder.conf" do
  source "follower_builder.conf.erb"
  owner "root"
  group "root"
  mode 00755
end

service "follower_builder" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end