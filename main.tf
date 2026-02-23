resource "azurerm_public_ip" "pip" {
  name                = "pip-tp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"   # Changé de Dynamic à Static
  sku                 = "Standard" # Ajouté pour corriger l'erreur 400
}

# 2. L'interface réseau (NIC) avec liaison IP Publique
resource "azurerm_network_interface" "nic" {
  name                = "nic-tp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    # CETTE LIGNE PERMET L'ACCÈS SSH DEPUIS CHEZ TOI :
    public_ip_address_id          = azurerm_public_ip.pip.id 
  }
}

# 3. Le Pare-feu (NSG) pour ouvrir le port 22
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-ssh-allow"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 4. Liaison du Pare-feu à la carte réseau
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# 5. La Machine Virtuelle
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-tp-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_password = var.admin_password
  disable_password_authentication = false
}