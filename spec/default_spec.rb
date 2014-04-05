# encoding: UTF-8
require 'chefspec'
require 'chefspec/berkshelf'

describe 'simplehtml-webserver::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['simplehtml-webserver']['htdocs'] = '/foo'
    end.converge(described_recipe)
  end

  it 'includes apt::default' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'includes apache2::default' do
    expect(chef_run).to include_recipe('apache2::default')
  end

  it 'includes iptables::default' do
    expect(chef_run).to include_recipe('iptables::default')
  end

  it 'creates web_app directory' do
    expect(chef_run).to create_directory('/foo')
  end

  it 'lays down a simple index.html in web_app directory' do
    expect(chef_run).to create_cookbook_file('/foo/index.html')
  end
end
