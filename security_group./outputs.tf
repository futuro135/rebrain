output "security_group_name" {
  value = yandex_vpc_security_group.yn.name
}

output "security_group_id" {
  value = yandex_vpc_security_group.yn.id
}

output "allowed_ports" {
  value = var.allowed_ports
}