include_recipe "database::postgresql"

postgresql_connection_info = {
  host: 'localhost',
  username: 'postgres',
  password: node['postgresql']['password']['postgresql']
}

postgresql_database_user 'deploy' do
  action        :create
  connection    postgresql_connection_info
  password      node['postgresql']['password']['deploy']
end

postgresql_database 'twitterdb' do
  action        :create
  connection    postgresql_connection_info
end

postgresql_database_user 'deploy' do
  action        :grant
  connection    postgresql_connection_info
  database_name 'twitterdb'
  password      node['postgresql']['password']['deploy']
end