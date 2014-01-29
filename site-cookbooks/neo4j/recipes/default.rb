apt_repository 'neo4j' do
  uri          'http://debian.neo4j.org/repo'
  distribution 'stable/'
  deb_src      false
  key          'http://debian.neo4j.org/neotechnology.gpg.key'
end

package 'neo4j' do
  action :install
end

service 'neo4j' do
  action :start
  supports status: true, restart: true
end

# TODO: Auth extension
# directory '/usr/share/neo4j-contrib' do
#   action :create
# end

