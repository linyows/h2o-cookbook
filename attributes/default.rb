# Cookbook Name:: h2o
# Attributes:: default

default['h2o']['build'] = false

default['h2o']['pid'], \
default['h2o']['user'], \
default['h2o']['group'], \
default['h2o']['bin'] = if node['h2o']['build']
    %w(/var/run/h2o.pid h2o h2o /usr/local/bin)
  else
    %w(/var/run/h2o/h2o.pid nobody nogroup /usr/sbin)
  end

default['h2o']['pkg_platform'] = case node['platform']
  when 'centos'
    'CentOS_7'
  when 'fedora'
    'Fedora_21'
  when 'ScientificLinux'
    'ScientificLinux_7'
  end

default['h2o']['conf_cookbook']      = 'h2o'
default['h2o']['logdir']             = '/var/log/h2o'
default['h2o']['default_html']       = true

case node['platform_family']
when 'rhel', 'fedora'
  default['h2o']['systemd_unit_dir'] = '/usr/lib/systemd/system'
when 'debian'
  default['h2o']['systemd_unit_dir'] = '/lib/systemd/system'
end
default['h2o']['systemd_private_tmp'] = true

# package

case node['platform_family']
when 'rhel', 'fedora'
  default['h2o']['repository'] = "http://download.opensuse.org/repositories/home:funzoneq/#{node['h2o']['pkg_platform']}/home:funzoneq.repo"
when 'debian'
  default['h2o']['repository'] = 'http://dl.bintray.com/tatsushid/h2o-deb'
  default['h2o']['repository_key'] = 'https://bintray.com/user/downloadSubjectPublicKey?username=bintray'
  default['h2o']['repository_distribution'] = "#{node['lsb']['codename']}-backports"
end

# source
default['h2o']['download_version']   = '2.2.5'
default['h2o']['download_url']       = "https://github.com/h2o/h2o/archive/v#{node['h2o']['download_version']}.zip"
default['h2o']['download_checksum']  = '1fbd2e06c2d3d9d8e844d64439513b1947684e0c09a65ddaa9e77a2af77791c0'
default['h2o']['dir']                = '/etc/h2o'
default['h2o']['init_cookbook']      = 'h2o'
default['h2o']['logrotate_cookbook'] = 'h2o'
