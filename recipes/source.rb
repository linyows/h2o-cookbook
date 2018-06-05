# Cookbook Name:: h2o
# Recipe:: source

build_essential 'install_build_packages'

case node['platform_family']
when 'rhel', 'fedora'
  package %w[curl unzip cmake openssl-devel libyaml-devel]
when 'debian'
  package %w[curl unzip cmake pkg-config libssl-dev zlib1g-dev]
end

version = node['h2o']['download_version']
cache_path = Chef::Config[:file_cache_path]

remote_file "#{cache_path}/h2o-#{version}.zip" do
  source node['h2o']['download_url']
  checksum node['h2o']['download_checksum']
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
  not_if "/usr/local/bin/h2o -v 2>&1 | grep -q #{version}"
end
