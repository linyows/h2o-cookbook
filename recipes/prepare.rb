# Cookbook Name:: h2o
# Recipe:: prepare

directory node['h2o']['logdir'] do
  action :create
  owner 'root'
  mode '0755'
end

directory node['h2o']['dir'] do
  action :create
  owner 'root'
  mode '0755'
end

group node['h2o']['group'] do
  system true
end

user node['h2o']['user'] do
  system true
  shell '/bin/false'
  gid node['h2o']['group']
  home '/var/www'
  comment 'Service user for h2o'
end

template '/etc/logrotate.d/h2o' do
  source 'h2o.logrotate.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['logrotate_cookbook']
end
