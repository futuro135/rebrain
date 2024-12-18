terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    aws = {
      source  = "hashicorp/aws"
    }
  }
  # бэкенд типа s3
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "cf632254dff75f3ce19f12fd3a54bf11"
    region = "ru-central1"
    key    = "terraform.tfstate"
    skip_region_validation      = true
    #skip_credentials_validation = true
  }
}

# создаёт провайдера Yandex Cloud и устанавливает параметры для подключения к Yandex Cloud (зону размещения)
provider "yandex" {
  zone = "ru-central1-b"
  service_account_key_file = "authorized_key.json"
###########################################################################
  folder_id = var.yc_folder_id  # Всегда меняем Folder ID !!
###########################################################################
  access_key = var.s3_access_key 
  secret_key = var.s3_secret_key
}

