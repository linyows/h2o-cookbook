# Cookbook Name:: h2o
# Attributes:: default

default['h2o']['version']            = '1.5.4'
default['h2o']['download_url']       = "https://github.com/h2o/h2o/archive/v#{default['h2o']['version']}.zip"
default['h2o']['user']               = 'h2o'
default['h2o']['pid']                = '/var/run/h2o.pid'
default['h2o']['dir']                = '/etc/h2o'
default['h2o']['init_cookbook']      = 'h2o'
default['h2o']['conf_cookbook']      = 'h2o'
default['h2o']['logrotate_cookbook'] = 'h2o'
