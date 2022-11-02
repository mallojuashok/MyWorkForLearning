resource "azurerm_resource_group" "test" {
  name                      = "test_Tf"
  location                  = "Central Us"
}
resource "azurerm_virtual_network" "Vnet" {
  name                      = "Vnet-Tf"
  location                  = azurerm_resource_group.test.location
  resource_group_name       = azurerm_resource_group.test.name
  address_space             = ["192.168.0.0/16"]
}
resource "azurerm_subnet" "Web" {
    name                    = "Web-subnet"
    resource_group_name     = azurerm_resource_group.test.name 
    virtual_network_name    = azurerm_virtual_network.Vnet.name
    address_prefixes        = [ "192.168.0.0/24" ]
  
}
resource "azurerm_subnet" "Web1" {
    name                    = "Web1-subnet"
    resource_group_name     = azurerm_resource_group.test.name 
    virtual_network_name    = azurerm_virtual_network.Vnet.name
    address_prefixes        = [ "192.168.1.0/24" ]
  
}
resource "azurerm_network_security_group" "MySG" {
    name                    = "MySGRule"
    location                = azurerm_resource_group.test.location
    resource_group_name     = azurerm_resource_group.test.name
    security_rule{
        name                            = "test"
        priority                        = 500
        direction                       = "Inbound"
        access                          = "Allow"
        protocol                        = "Tcp"
        source_port_range               = "*"
        destination_port_range          = "*"
        source_address_prefix           = "*"
        destination_address_prefix      = "*"
    }
}
resource "azurerm_subnet_network_security_group_association" "SubnetAsscociationweb" {
    subnet_id                           = azurerm_subnet.Web.id
    network_security_group_id           = azurerm_network_security_group.MySG.id
  
}
resource "azurerm_subnet_network_security_group_association" "SubnetAsscociationweb1" {
    subnet_id                           = azurerm_subnet.Web1.id
    network_security_group_id           = azurerm_network_security_group.MySG.id
  
}
resource "azurerm_network_interface" "My-Nic" {
    name                    = "My-Nic-Tf"
    location                = azurerm_resource_group.test.location
    resource_group_name     = azurerm_resource_group.test.name
    ip_configuration {
      name                  = "mynicconfig"
      subnet_id             = azurerm_subnet.Web.id
    private_ip_address_allocation = "Dynamic"
    }       
}
resource "azurerm_virtual_machine" "MYVM-TERRA" {
    name                        = "MyVm-Tf"
    location                    = azurerm_resource_group.test.location
    resource_group_name         = azurerm_resource_group.test.name
    network_interface_ids       = [azurerm_network_interface.My-Nic.id]
    vm_size                     = "Standard_DS1_v2"
    storage_image_reference {
    publisher                   = "Canonical"
    offer                       = "UbuntuServer"
    sku                         = "18.04-LTS"
    version                     = "latest"
     }
    storage_os_disk {
    name                        = "myosdisk1"
    caching                     = "ReadWrite"
    create_option               = "FromImage"
    managed_disk_type           = "Standard_LRS"
    }
    os_profile {
    computer_name               = "hp"
    admin_username              = "devops"
    admin_password              = "devops@123456"
  }
    os_profile_linux_config {
    disable_password_authentication = false
  }
  
}