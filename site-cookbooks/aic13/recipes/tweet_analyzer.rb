git "/home/deploy/tweet_analyzer" do
  repository "git://github.com/aic2013/TweetAnalyzer.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
  notifies :restart, "service[tweet_analyzer]"
end

file "/var/log/aic13_tweet_analyzer.log" do
  owner 'deploy'
  group 'deploy'
  mode "0777"
  action :create
end

template "/home/deploy/tweet_analyzer/run_tweet_analyzer.sh" do
  source "run_tweet_analyzer.sh.erb"
  owner "deploy"
  group "deploy"
  mode 00700
end

template "/etc/init/tweet_analyzer.conf" do
  source "tweet_analyzer.conf.erb"
  owner "root"
  group "root"
  mode 00755
end

service "tweet_analyzer" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end