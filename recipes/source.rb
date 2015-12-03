# Cookbook Name:: h2o
# Recipe:: source

include_recipe 'build-essential'
include_recipe 'cmake::_source'

%w(
  curl
  unzip
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
    /usr/local/bin/cmake -DWITH_BUNDLED_SSL=on .
    make && make install
  CODE
  not_if "/usr/local/bin/h2o -v 2>&1 | grep -q #{version}"
end

if node['platform_family'] == 'rhel' && node['platform_version'].to_i >= 7
  execute 'systemctl daemon-reload for h2o' do
    command 'systemctl daemon-reload'
    action :nothing
  end

  template '/usr/lib/systemd/system/h2o.service' do
    source 'h2o.service.erb'
    owner 'root'
    group node['root_group']
    mode '0755'
    cookbook node['h2o']['init_cookbook']
    notifies :run, 'execute[systemctl daemon-reload for h2o]', :immediately
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

user node['h2o']['user'] do
  system true
  shell '/bin/false'
  home '/var/www'
  comment 'Service user for h2o'
end

template '/etc/h2o/h2o.conf' do
  source 'h2o.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['conf_cookbook']
end

template '/etc/logrotate.d/h2o' do
  source 'h2o.logrotate.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['logrotate_cookbook']
end
