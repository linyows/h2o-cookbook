# Cookbook Name:: h2o
# Attributes:: default

default['h2o']['build'] = false

version, pid, user, bin = if node['h2o']['build']
    %w(1.5.4 /var/run/h2o.pid h2o /usr/local/bin)
  else
    %w(1.2.0-20.1 /var/run/h2o/h2o.pid nobody /usr/sbin)
  end

platform = case node['platform']
  when 'centos'
    'CentOS_7'
  when 'fedora'
    'Fedora_21'
  when 'ScientificLinux'
    'ScientificLinux_7'
  end

default['h2o']['version']            = version
default['h2o']['pid']                = pid
default['h2o']['user']               = user
default['h2o']['bin']                = bin
default['h2o']['group']              = user == 'h2o' ? 'h2o' : nil
default['h2o']['conf_cookbook']      = 'h2o'
default['h2o']['logdir']             = '/var/log/h2o'
default['h2o']['default_html']       = true

# package
default['h2o']['repository']         = "http://download.opensuse.org/repositories/home:funzoneq/#{platform}/home:funzoneq.repo"

# source
default['h2o']['download_url']       = "https://github.com/h2o/h2o/archive/v#{version}.zip"
default['h2o']['dir']                = '/etc/h2o'
default['h2o']['init_cookbook']      = 'h2o'
default['h2o']['logrotate_cookbook'] = 'h2o'
