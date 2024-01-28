
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_cloudinit_disk" "cloudinit_disk" {
  name           = "${var.guest_name}.iso"
  pool           = var.storage_pool
  user_data      = var.cloud_init_user_data
  meta_data      = templatefile("${path.module}/cloud-init/meta-data", {
    hostname = var.guest_name
  })
  network_config = templatefile("${path.module}/cloud-init/network-config-${var.subnet_type}", {
    ip_address      = var.ip_address
    gateway_address = var.gateway_address
    dns_server      = var.dns_server
  })
}

resource "libvirt_volume" "primary_disk" {
  name             = "${var.guest_name}.qcow2"
  pool             = var.storage_pool
  base_volume_name = var.base_volume_name
  size             = var.base_volume_size
}

resource "libvirt_domain" "guest_domain" {
  name = var.guest_name

  cpu {
    mode = "host-passthrough"
  }
  vcpu   = var.vcpu
  memory = var.memory

  disk {
    volume_id = libvirt_volume.primary_disk.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit_disk.id

  network_interface {
    hostname       = "master"
    network_name   = var.network_name
    wait_for_lease = false
  }

  graphics {
    type = "vnc"
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

}
