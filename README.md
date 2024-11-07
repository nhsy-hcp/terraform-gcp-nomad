# Nomad and Consul Setup on GCP

This guide outlines how to deploy **Nomad** and **Consul** on **Google Cloud Platform (GCP)** using **Packer** to build custom images based on HashiCorp's [Reference Architecture](https://developer.hashicorp.com/nomad/tutorials/enterprise/production-reference-architecture-vm-with-consul).

![Reference Diagram](./docs/reference-diagram.png)

## Prerequisites

Before you begin, ensure you have the following tools installed:
- [Homebrew](https://brew.sh/)
- [Homebrew HashiCorp tap](https://github.com/hashicorp/homebrew-tap) `brew tap hashicorp/tap`
- [Google Cloud CLI (gcloud)](https://cloud.google.com/sdk/docs/install) `brew install google-cloud-sdk`
- [HashiCorp Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli) `brew install hashicorp/tap/packer`
- [HashiCorp Terraform](https://developer.hashicorp.com/terraform/install) `brew install hashicorp/tap/terraform`
- [Task](https://taskfile.dev/installation/) `brew install go-task/tap/go-task`
- **Nomad License File**
- **Consul License File**

## Usage
### Step 1: Authenticate with GCP

Authenticate your GCP account and configure the project you want to use:

```bash
# Authenticate your GCP account with application-default
gcloud auth application-default login

# Authenticate your GCP account with application-default
gcloud auth login

# Set your Google Cloud project ID
gcloud config set project <PROJECT_ID>
```

Replace `<PROJECT_ID>` with your GCP project ID.

### Step 2: Set Up License Files

Copy your **Nomad** and **Consul** license files (`nomad.hclic` and `consul.hclic`) to the root of your working directory:

```bash
cp ~/Downloads/nomad.hclic .
cp ~/Downloads/consul.hclic .
```

Ensure both license files (consul.hclic and nomad.hclic) are present in the root folder before building your images.

### Step 3: Build Disk Images with Packer
```
task packer
```

### Step 4: Provision Nomad Cluster with Terraform
```
task apply
```

### Firewall Configuration
The firewall rule will open TCP ports 4646 and 8500, allowing you to access Nomad on port 4646 and Consul on port 8500 on the relevant the servers. You can access these services via a web browser using the external IP addresses of your servers. 

### Destroy the Infrastructure
```
task destroy
```

Delete all packer created images
```
task clean
```