#default['meanapp-pipeline']['jenkins']['plugins'] = %w{ scm-api git git-client github-api github chef-identity }

default['meanapp-pipeline']['jenkins']['plugins'] = {"scm-api"=>nil,"git"=>nil,"git-client"=>'1.11.0',"github-api"=>nil,"github"=>nil,"chef-identity"=>nil}