
resource "libvirt_cloudinit_disk" "cloudinit_disk" {
  name      = "${var.guest_name}.iso"
  pool      = var.storage_pool
  user_data = var.cloud_init_user_data
  meta_data = templatefile("${path.module}/cloud-init/meta-data", {
    guest_name = var.guest_name
    hostname   = var.hostname
  })
  network_config = templatefile("${path.module}/cloud-init/network-config-${var.subnet_type}", {
    network_interface = var.network_interface
    ip_address        = var.ip_address
    gateway_address   = var.gateway_address
    dns_server        = var.dns_server
  })

}
