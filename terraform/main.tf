terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}

provider "random" {}

resource "random_pet" "example" {
  length = 2
}

output "pet_name" {
  value = random_pet.example.id
}
