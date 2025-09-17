variable "project_name" {
  description = "Project name prefix"
  default     = "pablo-expensy"
}

variable "location" {
  description = "Azure region"
  default     = "eastus"
}

variable "node_size" {
  description = "VM size for AKS nodes"
  default     = "Standard_B2ms"
}

variable "node_count" {
  description = "Number of nodes in default node pool"
  default     = 2
}
