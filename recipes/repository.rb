# Cookbook Name:: h2o
# Recipe:: repository

case node['platform_family']
when 'rhel', 'fedora'
  remote_file '/etc/yum.repos.d/h2o.repo' do
    source node['h2o']['repository']
  end
when 'debian'
  apt_repository 'h2o' do
    uri node['h2o']['repository']
    key node['h2o']['repository_key']
    distribution node['h2o']['repository_distribution']
    components %w(main)
  end
end
