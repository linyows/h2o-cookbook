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
