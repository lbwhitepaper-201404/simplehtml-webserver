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

directory node['simplehtml-webserver']['htdocs'] do
  recursive true
end

cookbook_file ::File.join(
                  node['simplehtml-webserver']['htdocs'], 'index.html') do
  source 'index.html'
end

web_app 'simplehtml-webserver' do
  server_name '0.0.0.0'
  server_aliases ['.']
  docroot node['simplehtml-webserver']['htdocs']
  cookbook 'apache2'
end
