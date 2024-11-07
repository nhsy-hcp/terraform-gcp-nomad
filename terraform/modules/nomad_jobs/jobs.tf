resource "google_compute_firewall" "nomad_mgmt" {
  count = var.create_nomad_jobs ? 1 : 0

  name    = "${var.name_prefix}-nomad-jobs-ingress"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "3000",
      "8080",
      "9090",
    ]
  }

  source_ranges = [var.mgmt_cidr]
  target_tags   = ["nomad-client"]
}

data "local_file" "grafana_dashboard" {
  filename = "${path.module}/templates/grafana_dashboard.json"
}

resource "nomad_job" "traefik" {
  count = var.create_nomad_jobs ? 1 : 0

  jobspec = file("${path.module}/templates/traefik.nomad")
}

resource "nomad_job" "prometheus" {
  count = var.create_nomad_jobs ? 1 : 0

  jobspec = file("${path.module}/templates/prometheus.nomad")
}

resource "nomad_job" "grafana" {
  count = var.create_nomad_jobs ? 1 : 0

  jobspec = templatefile("${path.module}/templates/grafana.nomad", {
    grafana_dashboard = data.local_file.grafana_dashboard.content
  })
}

resource "nomad_job" "webapp" {
  count = var.create_nomad_jobs ? 1 : 0

  jobspec = file("${path.module}/templates/webapp.nomad")
}
