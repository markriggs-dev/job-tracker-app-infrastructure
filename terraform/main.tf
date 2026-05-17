terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "linode" {
  token = var.linode_token
}

# SSH key registered with Akamai — used for root access to the VPS
resource "linode_sshkey" "deployer" {
  label   = "job-tracker-deployer"
  ssh_key = var.ssh_public_key
}

# Firewall — allow SSH, HTTP, HTTPS; drop everything else inbound
resource "linode_firewall" "job_tracker" {
  label = "job-tracker-firewall"

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  linodes = [linode_instance.job_tracker.id]
}

# VPS — 4GB shared CPU (g6-standard-2)
resource "linode_instance" "job_tracker" {
  label           = "job-tracker"
  region          = var.region
  type            = "g6-standard-2"
  image           = "linode/debian12"
  root_pass       = var.root_password
  authorized_keys = [linode_sshkey.deployer.ssh_key]

  tags = ["job-tracker", "portfolio"]
}
