provider "google" {
  project = var.project_id
  region  = var.region
}

provider "nomad" {
  address = "http://${module.nomad.fqdn}:4646" #local.nomad_url
  region  = var.region
}
