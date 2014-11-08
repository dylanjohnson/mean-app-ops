#
# CookbookName:: meanapp-pipeline
# recipe:: jenkins
#
# Recipe overriding the default pipeline cookbook's Jenkins plugins attribute with a hash instead of an array.
# This allows for versioning of the plugins, which fixes an issue where s plugin maintainer messes up release versioning
#

include_recipe "java"
include_recipe "jenkins::master"
include_recipe "git"

jenkins_command 'safe-restart' do
  action :nothing
end

node['meanapp-pipeline']['jenkins']['plugins'].each do |p,v|
  jenkins_plugin p do
    if v
      version v
    end
    action :install
    notifies :execute, "jenkins_command[safe-restart]", :delayed
  end
end

sudo 'jenkins' do
  user      "jenkins"
  nopasswd  true
  commands  ['/usr/bin/chef-client']
end