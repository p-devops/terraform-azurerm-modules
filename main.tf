provider "azurerm" {
    features {}
}

module "vnet" {
    source  = "app.terraform.io/kevindemos/custom-vnet/azure"
    version = "1.0.0"

    identifier = var.identifier
    location = var.location
}

module "custom_sg" {
    source  = "app.terraform.io/kevindemos/custom-sg/azure"
    version = "1.0.0"

    res_group_name = module.vnet.res_group_name
    identifier = var.identifier
    location = var.location
    subnet_id = module.vnet.subnet_id

}

module "blob" {
    source  = "app.terraform.io/kevindemos/custom-blob/azure"
    version = "1.0.0"

    location = var.location
    res_group_name = module.vnet.res_group_name
}

module "custom_vm" {
    source  = "app.terraform.io/kevindemos/custom-vm/azure"
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

# resource "azurerm_network_security_group" "network-sg-2" {
#     name                = "${var.identifier}-sg-2"
#     location            = var.location
#     resource_group_name = module.vnet.res_group_name

#     security_rule {
#         name                       = "Admin"
#         priority                   = 1001
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "8080"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#     }

#     tags = {
#         environment = "Terraform Demo"
#         Key = "DoNotDelete"
#     }
# }

# resource "azurerm_subnet_network_security_group_association" "nsg-assoc-2" {
#     subnet_id                 = module.vnet.subnet_id
#     network_security_group_id = azurerm_network_security_group.network-sg-2.id
# }
