# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  def workspace
    if @workspace.nil?
      @workspace = read_workspace_path
      @workspace = create_workspace if @workspace.empty? || !FileTest::exists?(@workspace)
    end
    @workspace
  end

  def read_workspace_path
    `cat .workspace 2>/dev/null`.chomp
  end

  def create_workspace
    workspace = Dir.mktmpdir('h2o-cookbook')
    `echo -n "#{workspace}" > .workspace`
    workspace
  end

  def sync_workspace
    src = File.expand_path('../', __FILE__)
    dst = File.join(workspace, 'h2o')
    FileUtils.rm_rf dst
    FileUtils.cp_r src, dst
  end

  Dir.chdir(File.expand_path '../', __FILE__)
  sync_workspace

  config.vm.define :centos do |c|
    c.vm.hostname = 'centos'
    c.vm.box = 'linyows/centos-7.1_chef-12.2_puppet-3.7'
    c.vm.network :private_network, ip: '192.168.70.15'
    c.vm.provision :chef_zero do |chef|
      #chef.cookbooks_path = %w(vendor/cookbooks)
      chef.cookbooks_path = [workspace]
      #chef.add_recipe 'h2o'
      #chef.json = { nginxxx: { build: true } }
    end
  end
end
