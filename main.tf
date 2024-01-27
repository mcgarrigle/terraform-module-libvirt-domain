
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
  meta_data      = var.cloud_init_meta_data
  network_config = var.cloud_init_network_config
}

resource "libvirt_volume" "primary_disk" {
  name   = "${var.guest_name}.qcow2"
  pool   = var.storage_pool
  source = var.image_url
}

resource "libvirt_domain" "guest_domain" {
  name = var.guest_name

  cpu {
    mode = "host-passthrough"
  }
  vcpu   = 2
  memory = 4096

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
