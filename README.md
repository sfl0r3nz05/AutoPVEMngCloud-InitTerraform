# Automate a Proxmox VM management using Cloud-init and Terraform

## Architecture

   ![terraform](./documentation/images/terraform.PNG)

## How to deploy

1. [Manually create an Ubuntu cloud-init template for Proxmox](./documentation/cloud-init-manually.md)
2. [Deploy VMs in Proxmox with Terraform](./documentation/dep-proxmox-vm-terraform.md)

   > A deployment example is included on `/terraform` project folder.

## To Do

1. Use terraform API to manage proxmox VMs.
2. Update terraform to link with ansible playbooks.
