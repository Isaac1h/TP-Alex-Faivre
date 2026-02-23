variable "location" {
  default = "France Central"
}

variable "prefix" {
  default = "tp-azure"
}

# Facultatif avec la clé SSH, mais utile pour ne pas casser le code existant
variable "admin_password" {
  type      = string
  sensitive = true
}