# -*- mode: ruby -*-
# vi: set ft=ruby :
# This is a Vagrant configuration file. It can be used to set up and manage
# virtual machines on your local system or in the cloud. See http://downloads.vagrantup.com/
# for downloads and installation instructions, and see http://docs.vagrantup.com/v2/
# for more information and configuring and using Vagrant.

PROJECT_NAME = 'meanapp'

Vagrant.configure("2") do |config|

  require 'chef'
  Chef::Config.from_file(File.join(File.dirname(__FILE__), '.chef', 'knife.rb'))

  # build server running Jenkins to test Ops and Dev
  config.vm.define "build" do |build|
    build.vm.box = 'chef/centos-6.5'

    build.omnibus.chef_version = '11.16.4'

    build.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '1236']
    end

    build.vm.network 'private_network', :ip => '192.168.88.10'
    build.vm.synced_folder ".", "/vagrant", :nfs => true

    build.vm.hostname = 'build.' + PROJECT_NAME + '.local'

    build.vm.provision 'chef_client' do |chef|
      chef.chef_server_url = Chef::Config[:chef_server_url]
      chef.log_level = Chef::Config[:log_level]
      chef.validation_key_path = Chef::Config[:validation_key]
      chef.validation_client_name = Chef::Config[:validation_client_name]

      chef.provisioning_path = '/etc/chef'

      # name it specific to my local so chef server can ID it; others should change to own unique name
      chef.node_name = 'dj_local_build'

      chef.add_role 'build'
    end
  end

  config.vm.define "full_app" do |full_app|
    full_app.vm.box = 'chef/centos-6.5'

    full_app.omnibus.chef_version = '11.6.0'

    full_app.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    full_app.vm.network 'private_network', :ip => '192.168.88.88'
    full_app.vm.synced_folder "./sample-app/", "/vagrant", :nfs => true

    full_app.vm.hostname = 'app.' + PROJECT_NAME + '.local'

    full_app.vm.provision 'chef_client' do |chef|
      chef.chef_server_url = Chef::Config[:chef_server_url]
      chef.log_level = Chef::Config[:log_level]
      chef.validation_key_path = Chef::Config[:validation_key]
      chef.validation_client_name = Chef::Config[:validation_client_name]

      chef.provisioning_path = '/etc/chef'

      # name it specific to my local so chef server can ID it; others should change to own unique name
      chef.node_name = 'tampadevops_local_full_app'

      chef.add_role 'full-app'
    end
  end
end
