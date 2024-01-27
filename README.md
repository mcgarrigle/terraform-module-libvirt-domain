Example domain deployment:

```
module "libvirt_domain_bar" {
  source = "./modules/terraform-module-libvirt-domain"

  guest_name           = "bar"
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "192.168.1.24"
  gateway_address      = "192.168.1.254"
  dns_server           = "192.168.1.254"
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}
```
Example cloud-init config files can be found in the ``cloud-init`` directory.
