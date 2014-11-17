#
# Cookbook Name:: pipeline
# Recipe:: knife
#
# Copyright 2014, Stephen Lauck <lauck@getchef.com>
# Copyright 2014, Chef, Inc.
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
chef_gem "chef-vault"

require 'chef-vault'

include_recipe 'chef-vault'

directory "#{node['jenkins']['master']['home']}/.chef" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['user']
  mode 0755
end

# search data bag chef_orgs for each chef server or org
# write out knife and pem
if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
  #orgs = search(:chef_orgs, "*:*")

  orgs = ['dylan_johnson']

  orgs.each do |org|
    # org = ChefVault::Item.load("chef_orgs", org)
    org = chef_vault_item("chef_orgs", org)

    #org_chef_server_url = chef_vault_item("chef_orgs", org['chef_server_url'])
    #org_client = chef_vault_item("chef_orgs", org['client'])
    #org_pem = chef_vault_item("chef_orgs", org['pem'])

    org_chef_server_url = org['chef_server_url']
    org_client = org['client']
    org_pem = org['pem']

    template "#{node['jenkins']['master']['home']}/.chef/knife.rb" do
      cookbook 'pipeline'
      source "knife.rb.erb"
      owner node['jenkins']['master']['user']
      group node['jenkins']['master']['group']
      mode 0644
      variables(
          :chef_server_url => org_chef_server_url,
          :client_node_name => org_client
      )
    end

    file "#{node['jenkins']['master']['home']}/.chef/#{org_client}.pem" do
      content org_pem
      owner node['jenkins']['master']['user']
      group node['jenkins']['master']['group']
      mode 0644
    end
  end
end
