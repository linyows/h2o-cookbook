# Cookbook Name:: h2o
# Recipe:: default

include_recipe 'build-essential'

%w(
  curl
  unzip
  cmake
  libyaml-devel
  openssl-devel
).each { |name| package name }

version = node['h2o']['version']
cache_path = Chef::Config[:file_cache_path]

remote_file "#{cache_path}/h2o-#{version}.zip" do
  source node['h2o']['download_url']
  action :create_if_missing
end

bash "expand h2o-#{version}" do
  not_if "test -d #{cache_path}/h2o-#{version}"
  code <<-CODE
    cd #{cache_path}
    unzip h2o-#{version}.zip
  CODE
end

bash "install h2o-#{version}" do
  code <<-CODE
    cd #{cache_path}/h2o-#{version}
    cmake -DWITH_BUNDLED_SSL=on .
    make && make install
  CODE
  #not_if "h2o -v 2>&1 | grep -q #{version}"
end

if node['platform_family'] == 'rhel' && node['platform_version'].to_i >= 7
  template '/usr/lib/systemd/system/h2o.service' do
    source 'h2o.service.erb'
    owner 'root'
    group node['root_group']
    mode '0755'
    cookbook node['h2o']['init_cookbook']
  end
else
  template '/etc/init.d/h2o' do
    source 'h2o.init.erb'
    owner 'root'
    group node['root_group']
    mode '0755'
    cookbook node['h2o']['init_cookbook']
  end
end

template '/etc/h2o/h2o.conf' do
  source 'h2o.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['conf_cookbook']
end

directory '/etc/h2o' do
  action :create
  owner 'root'
  mode '0755'
end

user node['h2o']['user'] do
  system true
  shell '/bin/false'
  home '/var/www'
end

template '/etc/logrotate.d/h2o' do
  source 'h2o.logrotate.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['logrotate_cookbook']
end
