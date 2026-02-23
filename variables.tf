variable "location" {
  description = "Région Azure pour le déploiement"
  type        = string
  default     = "France Central"
}

variable "prefix" {
  description = "Préfixe utilisé pour nommer les ressources"
  type        = string
  default     = "tp-azure"
}

variable "admin_password" {
  description = "Mot de passe de la VM"
  type        = string
  sensitive   = true
}