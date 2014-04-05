# encoding: UTF-8
#
# Cookbook Name:: simplehtml-webserver
# Recipe:: default
#
# Copyright 2014, Ryan J. Geyer <me@ryangeyer.com>
#
# All rights reserved - Do Not Redistribute
#

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

include_recipe 'apt::default'
include_recipe 'apache2::default'
include_recipe 'iptables::default'

directory node['simplehtml-webserver']['htdocs'] do
  recursive true
end

cookbook_file ::File.join(
                  node['simplehtml-webserver']['htdocs'], 'index.html') do
  source 'index.html'
end

web_app 'simplehtml-webserver' do
  server_name 'this gets ignored'
  server_aliases ['this also gets ignored']
  docroot node['simplehtml-webserver']['htdocs']
end

iptables_rule 'http_iptables_rule'
