# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  {
    'centos-7.1' => 'linyows/centos-7.1'
  }.each.with_index do |(name, box), i|
    config.vm.define name do |c|
      c.vm.hostname = [ 'h2o', name, %x(uname -n).chomp ].join('.')
      c.vm.box = box
      c.vm.network :private_network, ip: "192.168.50.20#{i}"

      c.vm.provision :chef_zero do |chef|
        chef.cookbooks_path = ['./vendor/cookbooks']
        chef.add_recipe 'h2o'
        #chef.json = { h2o: { build: true } }
      end
    end
  end
end
