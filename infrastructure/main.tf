terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "server" {
  # For now, it is assumed that the "server:latest" image
  # is already created.
  name = "server:latest"
  keep_locally = true  // Do not destroy!!!
}

resource "docker_network" "devops_net" {
  name = "devops-net"
  driver = "bridge"
  ipam_config {
    subnet = "172.18.0.0/16"
  }
}

resource "docker_container" "server_1" {
  name  = "server-1"
  image = docker_image.server.image_id
  hostname = "server-1"
  runtime = "sysbox-runc"
  tty = true
  stdin_open = true
  attach = false
  publish_all_ports = true

  networks_advanced {
    name = docker_network.devops_net.id
    ipv4_address = "172.18.0.2"
  }
}

resource "docker_container" "server_2" {
  name  = "server-2"
  image = docker_image.server.image_id
  hostname = "server-2"
  runtime = "sysbox-runc"
  tty = true
  stdin_open = true
  attach = false
  publish_all_ports = true

  networks_advanced {
    name = docker_network.devops_net.id
    ipv4_address = "172.18.0.3"
  }
}
