locals {
  mgmt_cidr             = "${chomp(data.http.mgmt_ip.response_body)}/32"
  name_prefix           = format("%s-%s", random_pet.default.id, var.datacenter)
  secondary_name_prefix = format("%s-%s", random_pet.default.id, var.secondary_datacenter)
}

resource "random_pet" "default" {
  length = 1
}
