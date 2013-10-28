
user 'deploy' do
  home '/home/deploy'
  shell '/bin/bash'
  supports manage_home: true
end

directory '/home/deploy/.ssh/authorized_keys' do
  source 'authorized_keys.erb'
  owner u
  group u
  mode "0600"
  variables keys: data_bag_item('users', 'production_deploy')['ssh_keys']
end