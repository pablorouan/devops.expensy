# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location

  tags = {
    owner       = "pablo"
    project     = var.project_name
    environment = "dev"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/16"]

  tags = {
    owner       = "pablo"
    project     = var.project_name
    environment = "dev"
  }
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.project_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log" {
  name                = "${var.project_name}-logs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    owner       = "pablo"
    project     = var.project_name
    environment = "dev"
  }
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project_name}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.project_name}-dns"

  default_node_pool {
    name            = "systempool"
    node_count      = var.node_count
    vm_size         = var.node_size
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  }

  tags = {
    owner       = "pablo"
    project     = var.project_name
    environment = "dev"
  }
}
