terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
    }
  }
  # required_version = "1.3.9"
}

provider "harness" {
   endpoint         = "https://smp2.harnesscx.io/gateway"
   account_id       = "pLaOZ3e-QmWOJld7ANsqow"
   platform_api_key = "pat.pLaOZ3e-QmWOJld7ANsqow.66b27f1203e5696ad707eaeb.5wva1kytOif7oiY4NgG5"
}

