Mean App Chef Repo
=====

A base Chef repository for managing the development lifecycle of MEAN-stack apps. This repo is designed to be a
submodule in a "paper clip" repo with one other submodule: the application source. It's designed to be the "Ops" half of
a team practicing DevOps methodology while building a MEAN app. This project just tracks (MEAN.js)[https://github.com/meanjs/mean]

## Getting Started
  - Install VirtualBox
  - Install Vagrant
  - Install ChefDK
  - Install `chef` as a Vagrant plugin: `vagrant plugin install chef`
  - Install `vagrant-omnibus` plugin: `vagrant plugin install vagrant-omnibus`
  - Add the VM(s) to `/etc/hosts` (or whatever that would be on Windows): `192.168.88.110  build.meanapp.local\ 192.168.88.188`
  - Converge the app kitchen: `cd cookbooks/mean-app && vagrant up`
  - Converge the build kitchen: `cd cookbooks/meanapp-pipeline && vagrant up`

**NOTE: this will set up a "mock" local environment using chef-zero and test-kitchen. The `Vagrantfile` at the root will
spin up a "real" local environment, but requires set up of a chef-server and chef-config. (TODO: add docs for setting up
hosted chef).**

## T(K)DD
This repo embraces Test Kitchen Driven Development of Chef assets. It uses Jenkins to monitor a git repository and run
Test Kitchen when the Chef repository changes (see the `build` role).

## Other stuff you'll need if you're using this on your own project
  - A Chef server; this example was built using Hosted Chef

## Gotchas
  - Sometimes the `jenkins_plugin` resources don't install correctly due to people jacking up their versioning (looking
  at you, `git-client` plugin). There's nothing we can do about that, so calm down, stop yelling, and go download the
  source and upload the plugin manually via `Manage Jenkins > Plugins > Advanced > Upload`, then re-provision your
  Vagrant box or re-converge your kitchen.

## HACKY INTEGRATION NOTICE
This repo (temporarily, shamelessly) embeds the (pipeline)[https://github.com/chef-solutions/pipeline] cookbooks, because the latest and greatest
isn't available on Supermarket. When `pipeline` becomes more mature and available, this hackiness will be stripped out
in favor of proper integration. This will likely cause BC breaks if you're using this repo, but them's the breaks (ha,
BC + breaks).

About Chef
=====
This repo is opinionated, and its opinion is that (Chef)[https://getchef.com] is the best configuration management tool
out there. The author is not writing with any intention of accommodating the use of Puppet, SaltStack, Ansible, or
whatever else you use. Sorry :(.

About MEAN
=====
MEAN stands for MongoDB, Express, AngularJS, and NodeJS. A full rundown is outside of the scope of this repo. For more
info, see the (MEAN.js project)[http://meanjs.org/].