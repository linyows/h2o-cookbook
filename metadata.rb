name             'h2o'
maintainer       'linyows'
maintainer_email 'linyows@gmail.com'
license          'MIT'
description      'Installs/Configures h2o'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'build-essential'
recipe 'h2o', 'Installs and configures h2o'
%w(centos redhat fedora ubuntu debian).each { |os| supports os }

source_url 'https://github.com/linyows/h2o-cookbook'
issues_url 'https://github.com/linyows/h2o-cookbook/issues'
chef_version '>= 13'
