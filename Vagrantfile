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

    build.omnibus.chef_version = :latest

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

      # name it specific to my local so chef server can ID it; others should change to own unique name
      chef.node_name = 'dj_local_build'

      chef.add_role 'build'
    end
  end
end
