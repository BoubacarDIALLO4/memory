resource "azurerm_public_ip" "edge" {
  allocation_method = "Dynamic"
  location = var.LOCATION
  name = "az104-07-pip0"
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_network_interface" "edge" {
  location = var.LOCATION
  name = "az104-07-nic0"
  resource_group_name = data.azurerm_resource_group.main.name
  ip_configuration {
    name = "default"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.edge.id
  }
}

resource "azurerm_network_security_group" "main" {
  location = var.LOCATION
  name = "az104-07-nsg0"
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    access = "Allow"
    direction = "Inbound"
    name = "AllowTCP"
    priority = 1000
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
    source_address_prefix = "*"

  }
}

resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "edge" {
  admin_password = var.PASSWORD
  admin_username = var.USER
  location = data.azurerm_resource_group.main.location
  name = var.VMNAME
  network_interface_ids = [azurerm_network_interface.edge.id]
  resource_group_name = data.azurerm_resource_group.main.name
  size = var.VM_DISK
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer = "Centos"
    publisher = "OpenLogic"
    sku = "7.7"
    version = "latest"
  }

  disable_password_authentication = false

  admin_ssh_key {
    username = var.USER
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

}

data "template_file" "bootstrap_edge" {
//  template = "${file("${path.module}/bootstrap.sh")}"
  template = file("boostrap.sh")

}

resource "azurerm_virtual_machine_extension" "vm_extension_edge_bootstrap" {
  name                 = "BootstrapEdge"
  virtual_machine_id   = azurerm_linux_virtual_machine.edge.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${base64encode(data.template_file.bootstrap_edge.rendered)}"
    }
  SETTINGS
}

//resource "azurerm_shared_image_version" "os_image" {
//  name                = "latest" # or use "recent" to get the latest updated image
//  image_name          = "Linux-Ubuntu" # this is the name of the image
//  gallery_name        = "lunix_image_20"
//  resource_group_name = "rg-az-test"
//  location            = var.LOCATION
//  managed_image_id    = azurerm_virtual_machine.main[0].id
//
//  target_region {
//    name = var.LOCATION
//    regional_replica_count = 1
//    storage_account_type = "Standard_LRS"
//
//  }
//}
//output "edge_ip" {
//  value = "azurerm_windows_virtual_machine.edge.public_ip_address"
//}