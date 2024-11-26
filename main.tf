terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
# создаёт провайдера Yandex Cloud и устанавливает параметры для подключения к Yandex Cloud (зону размещения)
provider "yandex" {
  zone = "ru-central1-b"
  service_account_key_file = "authorized_key.json"
###########################################################################
  folder_id = "b1gh75lmmclvcrte263d"   # Всегда меняем Folder ID !!
###########################################################################
}
# создаёт VPC
resource "yandex_vpc_network" "network_a" {
  name = "vpc_nikolskoy"
}
resource "yandex_vpc_subnet" "subnet_a" {
  name           = "subnet_nikolskoy"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network_a.id
  v4_cidr_blocks = ["192.168.120.0/24"]
}
################################################# VARs

###################################################
# ниже мы вызываем модуль (в нашем случае локальный)
module "security_group" {
  source  = "./security_group"
  allowed_ports = [22, 80, 443, 8080] # Список портов
  network_id = yandex_vpc_network.network_a.id
}

# объявляем ресурс (виртуальную машину) и его атрибуты (имя, платформа, ресурсы ВМ, загрузочный диск и сетевой интерфейс)
resource "yandex_compute_instance" "vm-nikolskoy" { 
  name        = "vm-nikolskoy"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8ba9d5mfvlncknt2kd"
    }
  }
  network_interface {
    index = 0
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat = true
    security_group_ids = [module.security_group.security_group_id]
  }
  scheduling_policy {
    preemptible = true
  }
}
