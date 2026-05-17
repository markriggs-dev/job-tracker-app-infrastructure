variable "linode_token" {
  description = "Akamai (Linode) API token with read/write access to Linodes, firewalls, and SSH keys"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key content (e.g. contents of ~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "root_password" {
  description = "Root password for the VPS — use a strong generated password, SSH key is the primary access method"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Akamai data center region (see: linode regions list)"
  type        = string
  default     = "us-central"  # Dallas — change to closest region
}
