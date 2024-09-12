# resource "google_compute_instance_group" "default" {
#   count       = var.nomad_server_instances
#   name        = "${var.name_prefix}-${data.google_compute_zones.default.names[count.index]}-nomad-grp"
#   description = "Nomad server group"
#   instances = [
#     for instance in google_compute_instance.nomad_servers : instance.self_link if instance.zone == data.google_compute_zones.default.names[count.index]
#   ]
#
#   named_port {
#     name = "http"
#     port = 4646
#   }
#   zone = data.google_compute_zones.default.names[count.index]
# }
#
# resource "google_compute_http_health_check" "default" {
#   name               = "${var.name_prefix}-nomad-hc"
#   check_interval_sec = 30
#   timeout_sec        = 5
#   port               = 4646
# }
#
# resource "google_compute_backend_service" "default" {
#   name      = "${var.name_prefix}-nomad-be"
#   port_name = "http"
#   protocol  = "HTTP"
#
#   dynamic "backend" {
#     for_each = google_compute_instance_group.default
#     content {
#       group = backend.value.id
#     }
#   }
#
#   health_checks = [
#     google_compute_http_health_check.default.id,
#   ]
# }