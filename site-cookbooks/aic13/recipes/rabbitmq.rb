rabbitmq_user "guest" do
  action :delete
end

rabbitmq_vhost node['rabbitmq']['vhost'] do
  action :add
end

rabbitmq_user node['rabbitmq']['user'] do
  action :add
  password node['rabbitmq']['password']
end

rabbitmq_user node['rabbitmq']['user'] do
  action :set_permissions
  vhost node['rabbitmq']['vhost']
  permissions ".* .* .*"
end

rabbitmq_user 'admin' do
  action :add
  password node['rabbitmq']['admin']
end

rabbitmq_user 'admin' do
  tag 'administrator'
  action :set_tags
end