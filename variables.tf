variable "location" {
    description = "Region to be created in"
}

variable "identifier" {
    description = "Unique identifier to avoid name collisions"
}

variable "vm_size" {
    description = "Size of the VM to create"
}

variable "linux_user" {
    description = "Name of initial Linux user"
}

variable "linux_password" {
    description = "Password for the Linux user"
}
