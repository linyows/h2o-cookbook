# Cookbook Name:: h2o
# Recipe:: default

if node['h2o']['build']
  include_recipe 'h2o::prepare'
  include_recipe 'h2o::source'

else
  include_recipe 'h2o::repository'

  group node['h2o']['group'] do
    system true
  end if node['h2o']['group'] != 'nogroup'

  user node['h2o']['user'] do
    system true
    shell '/bin/false'
    home '/var/www'
    gid node['h2o']['group'] if node['h2o']['group'] != 'nogroup'
    comment 'Service user for h2o'
  end if node['h2o']['user'] != 'nobody'

  package 'h2o' do
    version node['h2o']['version']
    action :install
  end
end

include_recipe 'h2o::html' if node['h2o']['default_html']
include_recipe 'h2o::config'

service 'h2o' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
