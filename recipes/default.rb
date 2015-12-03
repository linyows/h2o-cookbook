# Cookbook Name:: h2o
# Recipe:: default

if node['h2o']['build']
  include_recipe 'h2o::prepare'
  include_recipe 'h2o::source'

else
  include_recipe 'h2o::repository'
  package 'h2o' do
    version "#{node['h2o']['version']}"
    action :install
  end
end

include_recipe 'h2o::html' if node['h2o']['default_html']
include_recipe 'h2o::config'

service 'h2o' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
