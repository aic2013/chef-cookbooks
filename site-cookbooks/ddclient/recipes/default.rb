#
# Author:: Markus Mühlberger (<markus@mmuehlberger.com>)
# Cookbook Name:: ddclient
# Recipe:: default
#
# Copyright 2009, Markus Mühlberger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default[:ddclient][:domain] = node.name

package "ddclient" do
  action :install
end

service "ddclient" do
  action [ :enable, :start ]
  supports restart: true,
            status: true,
            reload: true
end

template "/etc/ddclient.conf" do
  source "ddclient.conf.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, "service[ddclient]"
end

template "/etc/default/ddclient" do
  source "ddclient.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, "service[ddclient]"
end
