variable "ssh_key" {
    default = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABRw/tYYRQHQI3n2HglfiYGgI0uzCBbB+9jrthhj5wDZFadotb10uNm5707TuljpkOt63s3fq8e7ZGBHGby9ummygH18xkvCdwEtOME+YpRvQX9jTuwubQeLrwPGFw9ozPVYR1igySEkTZwt3BCgZTlQ//dfW2dpO2z5eBBQuphgW/svQ== cserver@daimserver"
}

variable "proxmox_host" {
    default = "pve"
}

variable "template_name" {
    default = "ubuntu-2004-cloudinit-template"
}
