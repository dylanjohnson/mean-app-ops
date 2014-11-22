#
# Cookbook Name:: mean-app
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

# node
include_recipe 'nodejs'
include_recipe 'nodejs::npm'

# git
include_recipe 'git'

# install grunt globally
nodejs_npm 'grunt-cli'

# install bower globally
nodejs_npm 'bower'

# TODO: create an app-specific user

# TODO: make path an attribute and put this in a better place, i.e. /apps
# install app dependencies
nodejs_npm 'app' do
  path '/app'
  json true
end

# mongo
include_recipe 'mongodb::default'

# start grunt
execute 'grunt' do
  cwd '/app'
end