#!/bin/bash
set -e
#exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
if [ -f /var/log/user-data.log ]; then
	echo "userdata_skipped"
	exit 0
fi
exec &> >(tee -a /var/log/user-data.log)
gsutil cp gs://${GCS_BUCKET}/consul-client.hcl /etc/consul.d/consul.hcl
if [ "${NOMAD_ROLE}" == "server" ]; then
    gsutil cp gs://${GCS_BUCKET}/nomad-server.hcl /etc/nomad.d/nomad.hcl
else
    gsutil cp gs://${GCS_BUCKET}/nomad-client.hcl /etc/nomad.d/nomad.hcl
fi
sed -i 's/__DATACENTER__/${DATACENTER}/g' /etc/nomad.d/nomad.hcl /etc/consul.d/consul.hcl
sed -i 's/__REGION__/${REGION}/g' /etc/consul.d/consul.hcl
sed -i 's/__REGION__/${REGION}/g' /etc/nomad.d/nomad.hcl
systemctl enable consul
systemctl enable nomad
systemctl start consul
systemctl start nomad
echo "userdata_done"