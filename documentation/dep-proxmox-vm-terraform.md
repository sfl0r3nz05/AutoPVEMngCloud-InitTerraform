# Deploy VMs in Proxmox with Terraform

1. Install Terraform

    ```console
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    ```

    ```console
    sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    ```

    ```console
    sudo apt update
    ```

    ```console
    sudo apt install terraform
    ```

2. Determine Authentication Method (use API keys)

3. Terraform basic information and provider installation

    ```console
    cd ~
    mkdir terraform-test && cd terraform-test
    touch main.tf vars.tf
    ```

4. Modify `main.tf` file:

    ```console
    terraform {
        required_providers {
            proxmox = {
                source = "telmate/proxmox"
                version = "2.9.3"
                }
            }
        }
    ```

5. Initialize Terraform

    ```console
    terraform init
    ```

    - Expected output:

        ```console
        Initializing the backend...

        Initializing provider plugins...
        - Finding telmate/proxmox versions matching "2.9.3"...
        - Installing telmate/proxmox v2.9.3...
        - Installed telmate/proxmox v2.9.3 (self-signed, key ID A9EBBE091B35AFCE)
        ...
        ...
        Terraform has been successfully initialized!
        ...
        ...
        ```

6. Create a Terraform plan in `main.tf`:

    ```console
    provider "proxmox" {
  
        pm_api_url = "https://10.63.27.51:8006/api2/json"
        pm_api_token_id = "xxx@pam!xxx"
        pm_api_token_secret = "xxxxxxx"
        pm_tls_insecure = true
    }

    resource "proxmox_vm_qemu" "test_server" {
        count = 1
        name = "test-vm-${count.index + 1}"
        target_node = var.proxmox_host
        clone = var.template_name
        agent = 1
        os_type = "cloud-init"
        cores = 2
        sockets = 1
        cpu = "host"
        memory = 2048
        scsihw = "virtio-scsi-pci"
        bootdisk = "scsi0"
        disk {
            slot = 0
            size = "10G"
            type = "scsi"
            storage = "local-lvm"
            iothread = 1
        }
  
        network {
            model = "virtio"
            bridge = "vmbr0"
        }

        lifecycle {
            ignore_changes = [
                network,
            ]
        }
  
        ipconfig0 = "ip=10.63.27.5${count.index + 7}/24,gw=10.63.27.1"
  
        sshkeys = <<EOF
        ${var.ssh_key}
        EOF
    }
    ```

7. Create a `vars.tf` file including the following fields:

    > *variable "ssh_key" refers to public key generated in the terraform controller.*

    ```console
    variable "ssh_key" {
        default = "xxx"
    }

    variable "proxmox_host" {
        default = "xxx"
    }

    variable "template_name" {
        default = "xxx"
    }
    ```
