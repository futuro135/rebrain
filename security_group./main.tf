terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_security_group" "yn" {
  name        = "security-group-example"
  description = "Группа безопасности для доступа к ВМ"
  network_id  = var.network_id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port      = ingress.value
      to_port        = ingress.value
      protocol       = "tcp"
      v4_cidr_blocks = ["0.0.0.0/0"] # Доступ из интернета
    }
  }

  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}