Example domain deployment:

```
module "libvirt_domain_foo" {
  source = "./modules/terraform-module-libvirt-domain"

  guest_name = "foo"
  cloud_init_user_data      = templatefile("${path.module}/cloud-init/user-data", {})
  cloud_init_meta_data      = templatefile("${path.module}/cloud-init/meta-data", { hostname = "foo" })
  cloud_init_network_config = templatefile("${path.module}/cloud-init/network-config-dhcp", {})
}
```
Example cloud-init config files can be found in the ``cloud-init`` directory.
