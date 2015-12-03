# Cookbook Name:: h2o
# Recipe:: default

if node['h2o']['build']
  include_recipe 'h2o::source'
else
  include_recipe 'h2o::repository'

  package 'h2o' do
    version "#{node['h2o']['version']}-#{node['h2o']['release']}"
    action :install
    options '--disablerepo=* --enablerepo=h2o'
  end
end

include_recipe 'h2o::html'

service 'h2o' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
