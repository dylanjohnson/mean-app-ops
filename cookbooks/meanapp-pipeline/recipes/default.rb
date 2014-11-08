#
# Cookbook Name:: meanapp-pipeline
# Recipe:: default
#
# Copyright (C) 2014 
#
# A case-specific wrapper around the default run list and config from community pipeline cookbook

include_recipe 'emacs'
include_recipe 'resolver'

#temporarily override the pipeline::jenkins recipe because git-client plugin fails
include_recipe 'meanapp-pipeline::jenkins'

include_recipe 'pipeline::chefdk'
include_recipe 'chef-zero'
include_recipe 'pipeline::knife'
include_recipe 'pipeline::jobs'