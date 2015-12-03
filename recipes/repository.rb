# Cookbook Name:: h2o
# Recipe:: repository

case node['platform_family']
when 'rhel', 'fedora'
  remote_file '/etc/yum.repos.d/h2o.repo' do
    source node['h2o']['repository']
  end
end
