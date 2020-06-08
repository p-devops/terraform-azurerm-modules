output "ssh" {
    value = "ssh ${var.linux_user}@${module.custom-vm.public-ip}"
}
