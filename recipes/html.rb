# Cookbook Name:: h2o
# Recipe:: html

directory '/usr/share/h2o/html' do
  action :create
  owner 'root'
  mode '0755'
  recursive true
end

cookbook_file '/usr/share/h2o/html/index.html' do
  source 'index.html'
end
