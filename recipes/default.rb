#
# Cookbook Name:: gdash
# Recipe:: default
#
# Copyright 2013, AT&T Services, Inc.
# Copyright 2011, Heavy Water Software Inc.
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

include_recipe "gdash::web"

gem_package "bundler"



#--------------------------
# expand gdash
#--------------------------

ark "gdash" do
  url node['gdash']['uri']
  extension "tar.gz"
  path "/opt"
  action :put
  owner node["gdash"]["owner"]
  group node["gdash"]["group"]
  notifies :run, "bash[bundle_install]", :immediate
end

bash "bundle_install" do
  action :nothing
  cwd node["gdash"]["base_dir"]
  user "root"
  code <<-EOF
    set -x
    bundle install
  EOF
end

# unintelligently assumes gdash base_dir ends in gdash
if node['recipes'].include? "infra-graphing::server"
  link "#{node['graphite']['doc_dir']}/gdash" do
    to node["gdash"]["base_dir"]
  end
end

directory File.join(node["gdash"]["base_dir"], "templates") do
  owner node["gdash"]["group"]
  group node["gdash"]["owner"]
end

directory File.join(node["gdash"]["base_dir"], "config") do
  owner node["gdash"]["owner"]
  group node["gdash"]["group"]
end

execute "bundle" do
  command "bundle install --binstubs #{File.join(node["gdash"]["base_dir"], 'bin')} --path #{File.join(node["gdash"]["base_dir"], 'vendor', 'bundle')}"
  cwd node["gdash"]["base_dir"]
  creates File.join(node["gdash"]["base_dir"], "bin")
  action :nothing
end

directory File.join(node["gdash"]["base_dir"], 'graph_templates', 'dashboards') do
  action :nothing
  recursive true
end

template File.join(node["gdash"]["base_dir"], "config", "gdash.yaml") do
  owner node["gdash"]["owner"]
  group node["gdash"]["group"]
end

# delete the sample graphs
directory "#{node['gdash']['base_dir']}/graph_templates/node_templates/" do
  action :delete
  recursive true
end

package "libyaml-perl" do
  action :install
end
