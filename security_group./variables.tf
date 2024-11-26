variable "allowed_ports" {
  type = list(number)
  default = [22, 80, 443]
  description = "Список портов, которые должны быть открыты для доступа из интернета"
}

variable "network_id" {
  type = string
  description = "ID сети VPC"
}