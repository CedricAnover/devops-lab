# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

require 'yaml'
conf = YAML.load_file('config.yml')

dot_env = {}
File.read(".env").split("\n").each do |ef|
  dot_env[ef.split("=")[0]] = ef.split("=")[1]
end

Vagrant.configure("2") do |config|
  # Triggers
  config.trigger.before :up do |trigger|
    trigger.name = "Remove All Containers"
    trigger.info = "Removing All Sysbox Container Servers"
    trigger.run = {inline: "docker container prune -f"}
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.network :private_network, type: "dhcp", docker_network__internal: true

  (1..conf["num_servers"]).each do |i|
    config.vm.define "server_#{i}" do |server|
      server.ssh.username = dot_env["SYS_CONTAINER_USERNAME"]
      server.ssh.password = dot_env["SYS_CONTAINER_PASSWD"]

      server.vm.provider "docker" do |d|
        d.name = "server-#{i}"  # Docker Container Name
        d.vagrant_machine = "server-#{i}"  # Vagrant Machine Name
        d.image = "nestybox/ubuntu-jammy-systemd-docker"
        d.create_args = [
          "--runtime=sysbox-runc", "-it", "-d", "-P",
          "--hostname=server-#{i}-host"
        ]
        d.remains_running = true
      end
    end
  end
end
