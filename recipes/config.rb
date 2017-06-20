# Cookbook Name:: h2o
# Recipe:: config

if node['platform_family'] == 'rhel' && node['platform_version'].to_i >= 7 ||
   node['platform_family'] == 'debian' && node['platform_version'].to_i >= 16
  execute 'systemctl daemon-reload for h2o' do
    command 'systemctl daemon-reload'
    action :nothing
  end

  template "#{node['h2o']['systemd_unit_dir']}/h2o.service" do
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

template '/etc/h2o/h2o.conf' do
  source 'h2o.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['h2o']['conf_cookbook']
end
