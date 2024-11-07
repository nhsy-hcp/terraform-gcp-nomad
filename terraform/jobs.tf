module "nomad_jobs" {
  count  = var.create_nomad_jobs ? 1 : 0
  source = "./modules/nomad_jobs"

  create_nomad_jobs = var.create_nomad_jobs
  project_id        = var.project_id
  mgmt_cidr         = local.mgmt_cidr
  network_name      = module.network.name
  nomad_fqdn        = module.nomad.fqdn

  depends_on = [
    null_resource.wait_for_nomad_api,
    null_resource.wait_for_secondary_nomad_api,
  ]
}