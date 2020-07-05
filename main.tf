provider "azurerm" {
    features {}
}

module "vnet" {
    source  = "app.terraform.io/peter-demo/custom-vnet/azurerm"
    version = "1.0.0"

    identifier = var.identifier
    location = var.location
}

module "custom_sg" {
    source  = "app.terraform.io/peter-demo/custom-sg/azurerm"
    version = "1.0.0"

    res_group_name = module.vnet.res_group_name
    identifier = var.identifier
    location = var.location
    subnet_id = module.vnet.subnet_id

}

module "blob" {
    source  = "app.terraform.io/peter-demo/custom-blob/azurerm"
    version = "1.0.0"

    location = var.location
    res_group_name = module.vnet.res_group_name
}

module "custom_vm" {
    source  = "app.terraform.io/peter-demo/custom-vm/azurerm"
    version = "1.0.3"

    identifier = var.identifier
    linux_password = var.linux_password
    linux_user = var.linux_user
    location = var.location
    res_group_name = module.vnet.res_group_name
    storage_endpoint = module.blob.storage_endpoint
    subnet_id = module.vnet.subnet_id
    vm_size = var.vm_size
}
