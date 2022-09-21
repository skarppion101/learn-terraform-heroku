terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.6.0"
    }

    herokux = {
      source  = "davidji99/herokux"
      version = "1.1.0"
    }
  }
  required_version = ">= 0.14"


#  cloud {
#    organization = "zhirobass-ltd"
#    hostname     = "app.terraform.io"
#    workspaces {
#      name = "getting-started"
#    }
#  }
}
