# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
conf = YAML.load_file('config.yml')

dot_env = {}
File.read(".env").split("\n").each do |ef|
  dot_env[ef.split("=")[0]] = ef.split("=")[1]
end

Vagrant.configure("2") do |config|
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Note: Need to manually (for now) create docker subnet before spinning up
  # the system containers for allocating static IP Addresses.

  (1..conf["num_servers"]).each do |i|
    config.vm.define "server_#{i}" do |server|
      server.vm.network :private_network, 
        ip: "172.18.0.#{i+1}", 
        name: "devops-net"

      server.vm.provider "docker" do |d|
        d.build_dir = "."
        d.dockerfile = "Dockerfile.server"
        d.build_args = ["-t", "server"]

        d.name = "server-#{i}"  # Docker Container Name
        d.vagrant_machine = "server-#{i}"  # Vagrant Machine Name
        d.create_args = [
          "--runtime=sysbox-runc", "-it", "-d", "-P",
          "--hostname=server-#{i}-host"
        ]
        d.remains_running = true
      end
    end
  end
end
