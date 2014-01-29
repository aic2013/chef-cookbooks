git "/home/deploy/follower_fetcher" do
  repository "git://github.com/aic2013/follower_fetcher.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
  notifies :restart, "service[follower_fetcher]"
end

file "/var/log/aic13_follower_fetcher.log" do
  owner 'deploy'
  group 'deploy'
  mode "0777"
  action :create
end

0.upto(4) do |i|
  template "/home/deploy/follower_fetcher/run_follower_fetcher_#{i}.sh" do
    source "run_follower_fetcher.sh.erb"
    owner "deploy"
    group "deploy"
    mode 00700
    variables fetcher_id: i
  end
end

file "/home/deploy/follower_fetcher/credentials.json" do
  content node[:twitter].to_json
  owner "deploy"
  group "deploy"
  mode 0600
  notifies :restart, 'service[follower_fetcher]'
end

template "/etc/init/follower_fetcher.conf" do
  source "follower_fetcher.conf.erb"
  owner "root"
  group "root"
  mode 00755
end

service "follower_fetcher" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end