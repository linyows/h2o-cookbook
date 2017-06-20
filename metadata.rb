name             'h2o'
maintainer       'linyows'
maintainer_email 'linyows@gmail.com'
license          'MIT'
description      'Installs/Configures h2o'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

depends 'build-essential'
depends 'cmake'
recipe 'h2o', 'Installs and configures h2o'
%w(centos redhat fedora ubuntu debian).each { |os| supports os }
