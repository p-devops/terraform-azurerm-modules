output "ssh" {
    value = "ssh ${var.linux_user}@${module.custom_vm.public-ip}"
}
