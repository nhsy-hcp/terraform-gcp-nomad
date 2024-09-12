module "nomad" {
  source                 = "./modules/nomad"
  datacenter             = var.datacenter
  gcs_bucket             = google_storage_bucket.default.name
  name_prefix            = local.name_prefix
  nomad_server_instances = var.nomad_server_instances
  project_id             = var.project_id
  region                 = var.region
  subnet_self_link       = module.network.subnet_self_link
  zone                   = data.google_compute_zones.default.names[0]

  depends_on = [module.network, module.consul]
}

module "secondary_nomad" {
  source                 = "./modules/nomad"
  datacenter             = var.secondary_datacenter
  gcs_bucket             = google_storage_bucket.default.name
  name_prefix            = local.secondary_name_prefix
  nomad_server_instances = var.nomad_server_instances
  project_id             = var.project_id
  region                 = var.secondary_region
  subnet_self_link       = module.network.secondary_subnet_self_link
  zone                   = data.google_compute_zones.secondary.names[0]

  depends_on = [module.network, module.secondary_consul]
}