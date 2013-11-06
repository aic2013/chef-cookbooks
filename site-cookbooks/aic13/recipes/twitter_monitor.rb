git "/home/deploy/twitter_monitor" do
  repository "git://github.com/aic2013/TwitterMonitor.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
end

template "/home/deploy/twitter_monitor/twitter4j.properties" do
  source "twitter.properties.erb"
  owner "deploy"
  group "deploy"
  mode 00600
end