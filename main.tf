# Create a resource group
resource "azurerm_resource_group" "avengers_group" {
    name     = "avengers-resources" # Name of the resource group
    location = "East US"           # Azure region
}

# Create a virtual network
resource "azurerm_virtual_network" "shield_vnet" {
    name                = "shield-vnet"            # Name of the virtual network
    address_space       = ["10.0.0.0/16"]          # Address space for the VNet
    location            = azurerm_resource_group.avengers_group.location # Use the same location as the resource group
    resource_group_name = azurerm_resource_group.avengers_group.name     # Associate with the resource group
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "stark_subnet" {
    name                 = "stark-subnet"          # Name of the subnet
    resource_group_name  = azurerm_resource_group.avengers_group.name     # Associate with the resource group
    virtual_network_name = azurerm_virtual_network.shield_vnet.name       # Associate with the virtual network
    address_prefixes     = ["10.0.1.0/24"]         # Address range for the subnet
}

# Create a public IP address for the VM
resource "azurerm_public_ip" "thor_pip" {
    name                = "thor-pip"               # Name of the public IP
    location            = azurerm_resource_group.avengers_group.location # Use the same location as the resource group
    resource_group_name = azurerm_resource_group.avengers_group.name     # Associate with the resource group
    allocation_method   = "Dynamic"                # Dynamic allocation of the public IP
}

# Create a network interface for the VM
resource "azurerm_network_interface" "hulk_nic" {
    name                = "hulk-nic"               # Name of the network interface
    location            = azurerm_resource_group.avengers_group.location # Use the same location as the resource group
    resource_group_name = azurerm_resource_group.avengers_group.name     # Associate with the resource group

    ip_configuration {
        name                          = "hulk-ip-config"             # Name of the IP configuration
        subnet_id                     = azurerm_subnet.stark_subnet.id # Associate with the subnet
        private_ip_address_allocation = "Dynamic"                    # Dynamic private IP allocation
        public_ip_address_id          = azurerm_public_ip.thor_pip.id # Associate with the public IP
    }
}

# Create a network security group
resource "azurerm_network_security_group" "avengers_nsg" {
    name                = "avengers-nsg"           # Name of the NSG
    location            = azurerm_resource_group.avengers_group.location # Use the same location as the resource group
    resource_group_name = azurerm_resource_group.avengers_group.name     # Associate with the resource group

    security_rule {
        name                       = "allow-ssh"   # Name of the rule
        priority                   = 1000          # Priority of the rule
        direction                  = "Inbound"     # Inbound traffic
        access                     = "Allow"       # Allow traffic
        protocol                   = "Tcp"         # Protocol type
        source_port_range          = "*"           # Source port range
        destination_port_range     = "22"          # Destination port (SSH)
        source_address_prefix      = "*"           # Source address range
        destination_address_prefix = "*"           # Destination address range
    }
}

# Associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "stark_subnet_nsg" {
    subnet_id                 = azurerm_subnet.stark_subnet.id # Associate with the subnet
    network_security_group_id = azurerm_network_security_group.avengers_nsg.id # Associate with the NSG
}
# Create a virtual machine
resource "azurerm_linux_virtual_machine" "ironman_vm" {
    name                = "ironman-vm"            # Name of the virtual machine
    location            = azurerm_resource_group.avengers_group.location # Use the same location as the resource group
    resource_group_name = azurerm_resource_group.avengers_group.name     # Associate with the resource group
    size                = "Standard_B1s"          # VM size (SKU)
    admin_username      = "tonystark"             # Admin username for the VM
    disable_password_authentication = false # Enable password authentication

    # Authentication using password
    admin_password = "Ms.Potts"                      # Admin password for the VM

    network_interface_ids = [azurerm_network_interface.hulk_nic.id] # Attach the network interface

    os_disk {
        caching              = "ReadWrite"          # Disk caching mode
        storage_account_type = "Standard_LRS"       # Storage type for the OS disk
    }


    source_image_reference {
        publisher = "Canonical"                     # Publisher of the image
        offer     = "UbuntuServer"                  # Offer of the image
        sku       = "18.04-LTS"                     # SKU of the image
        version   = "latest"                        # Use the latest version
    }
}