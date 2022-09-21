variable HEROKU_API_KEY {
  type      = string
  sensitive = true
}

variable HEROKU_EMAIL {
  type      = string
  sensitive = true
}

variable AIRTABLE_API_KEY {
  type      = string
  sensitive = true
}
variable AIRTABLE_APP_ID {
  type      = string
  sensitive = true
}
variable IMGUR_CLIENT_ID {
  type      = string
  sensitive = true
}
variable IMGUR_CLIENT_SECRET {
  type      = string
  sensitive = true
}
variable AUTH0_ISSUER_URL {
  type      = string
  sensitive = true
}
variable AUTH0_AUDIENCE {
  type      = string
  sensitive = true
}
variable DB_DROP_SCHEMA {
  sensitive = true
}
variable DB_TYPE {
  type      = string
  sensitive = true
}


provider "heroku" {
  # Configuration options
}
