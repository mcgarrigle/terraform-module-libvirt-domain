variable "image_url" {
  type    = string
  default = "http://node1.mac.wales:8081/repository/cloud-images/rocky/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
  # default = "http://ftp3.br.freebsd.org/pub/rocky/9.2/images/x86_64/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2"
}

variable "guest_name" {
  type    = string
  default = "terraform_test"
}

variable "hostname" {
  type    = string
  default = "terraformtest"
}

variable "vcpu" {
  type    = number
  default = 1
}

variable "memory" {
  type    = number
  default = 2048
}

variable "network_interface" {
  type    = string
  default = "eth0"
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "subnet_type" {
  type    = string
  default = "dhcp"
}

variable "ip_address" {
  type    = string
  default = ""
}

variable "gateway_address" {
  type    = string
  default = ""
}

variable "dns_server"{
  type    = string
  default = ""
}

variable "cloud_init_user_data" {
  type = string
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}

variable "base_volume_name" {
  type = string
}

variable "base_volume_size" {
  type    = number
  default = 2048 * (1024*1024)
}
