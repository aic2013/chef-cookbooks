git "/home/deploy/twitter_extractor" do
  repository "git://github.com/aic2013/TwitterExtractor.git"
  reference "master"
  action :sync
  user "deploy"
  group "deploy"
end

template "/home/deploy/twitter_extractor/hibernate.properties" do
  source "hibernate.properties.erb"
  owner "deploy"
  group "deploy"
  mode 00600
end