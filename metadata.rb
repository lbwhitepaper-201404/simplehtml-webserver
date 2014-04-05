# encoding: UTF-8
name             'simplehtml-webserver'
maintainer       'Ryan J. Geyer'
maintainer_email 'me@ryangeyer.com'
license          'All rights reserved'
description      'Installs/Configures simplehtml-webserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(marker apt apache2 iptables).each do |p|
  depends p
end
