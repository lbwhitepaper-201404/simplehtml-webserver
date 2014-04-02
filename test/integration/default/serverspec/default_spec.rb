# encoding: UTF-8
require 'spec_helper'

apache_name = ''

case backend.check_os[:family]
when 'Debian', 'Ubuntu'
  apache_name = 'apache2'
when 'RedHat'
  apache_name = 'httpd'
end

describe 'Packages are installed' do
  describe package(apache_name) do
    it { should be_installed }
  end
end

describe 'apache' do
  describe service(apache_name) do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe command('wget -q -O - http://localhost') do
    it { should return_stdout '<h1>Hello World!</h1>' }
  end

  describe command("ls /etc/#{apache_name}/sites-enabled/ | wc -l") do
    it { should return_stdout '1' }
  end
end
