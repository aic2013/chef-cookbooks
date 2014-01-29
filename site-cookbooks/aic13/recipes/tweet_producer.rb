git "/home/deploy/tweet_producer" do
  repository "git://github.com/aic2013/TweetProducer.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
  # notifies :restart, "service[tweet_producer]"
end

file "/var/log/aic13_tweet_producer.log" do
  owner 'deploy'
  group 'deploy'
  mode "0777"
  action :create
end

template "/home/deploy/tweet_producer/run_tweet_producer.sh" do
  source "run_tweet_producer.sh.erb"
  owner "deploy"
  group "deploy"
  mode 00700
end

template "/etc/init/tweet_producer.conf" do
  source "tweet_producer.conf.erb"
  owner "root"
  group "root"
  mode 00755
end

service "tweet_producer" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end