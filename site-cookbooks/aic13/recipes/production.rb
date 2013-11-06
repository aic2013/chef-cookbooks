user 'deploy' do
  home '/home/deploy'
  shell '/bin/bash'
  supports manage_home: true
end

directory '/home/deploy/.ssh' do
  owner 'deploy'
  group 'deploy'
  mode "0700"
  action :create
end

template '/home/deploy/.ssh/authorized_keys' do
  source 'authorized_keys.erb'
  owner 'deploy'
  group 'deploy'
  mode "0600"
  variables keys: data_bag_item('aic13', 'users')['ssh_keys']
end