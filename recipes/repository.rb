# Cookbook Name:: h2o
# Recipe:: repository

case node['platform_family']
when 'rhel', 'fedora'
  include_recipe 'yum::default'

  yum_repository 'h2o' do
    description 'h2o Repository'
    baseurl node['h2o']['repository']
    action :create
  end
end
