module "consul" {
  source = "./modules/consul"

  create_consul_cluster   = var.create_consul_cluster
  consul_server_instances = var.consul_server_instances
  datacenter              = var.datacenter
  gcs_bucket              = google_storage_bucket.default.name
  name_prefix             = local.name_prefix
  project_id              = var.project_id
  region                  = var.region
  subnet_self_link        = module.network.subnet_self_link
  zone                    = data.google_compute_zones.default.names[0]

  depends_on = [
    module.network,
    google_storage_bucket_object.config,
    google_storage_bucket_object.license
  ]
}

module "secondary_consul" {
  source = "./modules/consul"

  create_consul_cluster   = var.create_secondary_consul_cluster
  consul_server_instances = var.secondary_consul_server_instances
  datacenter              = var.secondary_datacenter
  gcs_bucket              = google_storage_bucket.default.name
  name_prefix             = local.secondary_name_prefix
  project_id              = var.project_id
  region                  = var.secondary_region
  subnet_self_link        = module.network.secondary_subnet_self_link
  zone                    = data.google_compute_zones.secondary.names[0]

  depends_on = [
    module.network,
    google_storage_bucket_object.config,
    google_storage_bucket_object.license
  ]
}