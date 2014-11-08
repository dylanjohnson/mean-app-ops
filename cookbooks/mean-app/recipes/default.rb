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

# mongo
include_recipe 'mongodb::default'