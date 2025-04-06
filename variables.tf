# Name of the resource group
variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

# Location for the resources
variable "location" {
  description = "Location for the resources"
  type        = string
}

# Name of the virtual network
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

# Name of the subnet
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

# Name of the public IP address
variable "public_ip_name" {
  description = "Name of the public IP address"
  type        = string
}

# Name of the network interface
variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

# Name of the network security group
variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

# Name of the virtual machine
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

# Size of the virtual machine
variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

# Admin username for the VM
variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

# Admin password for the VM
variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}