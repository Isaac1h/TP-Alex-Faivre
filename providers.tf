terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


# 1. Le Groupe de Ressources
resource "azurerm_resource_group" "rg" {
  name     = "rg-tp-azure"
  location = "France Central"
}

# 2. Le Réseau Virtuel
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-tp"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Le Sous-réseau
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

