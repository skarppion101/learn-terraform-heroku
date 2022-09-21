// Apps
resource "heroku_app" "dev_api" {
  name       = "terraform-lokr-room-api-dev"
  buildpacks = ["https://github.com/unfold/heroku-buildpack-pnpm.git"]
  region     = "eu"

  config_vars = {
    AIRTABLE_API_KEY    = var.AIRTABLE_API_KEY
    AIRTABLE_APP_ID     = var.AIRTABLE_APP_ID
    IMGUR_CLIENT_ID     = var.IMGUR_CLIENT_ID
    IMGUR_CLIENT_SECRET = var.IMGUR_CLIENT_SECRET
    AUTH0_ISSUER_URL    = var.AUTH0_ISSUER_URL
    AUTH0_AUDIENCE      = var.AUTH0_AUDIENCE
    DB_DROP_SCHEMA      = var.DB_DROP_SCHEMA
    DB_TYPE             = var.DB_TYPE
  }
}


// Domains
resource "heroku_domain" "default" {
  app_id      = heroku_app.dev_api.id
  hostname = "${heroku_app.dev_api.name}.herokuapp.com"
}


// Addons
resource "heroku_addon" "postgres" {
  app_id  = heroku_app.dev_api.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "simple_file_upload" {
  app_id  = heroku_app.dev_api.id
  plan = "simple-file-upload:staging"
}


// Pipelines
resource "heroku_pipeline" "development" {
  name = "lokr-room-api-dev-pipeline"
}


# Couple app to pipeline.
resource "heroku_pipeline_coupling" "app" {
  app_id   = heroku_app.dev_api.id
  pipeline = heroku_pipeline.development.id
  stage    = "development"
}

// Add the GitHub repository integration with the pipeline.
resource "herokux_pipeline_github_integration" "development" {
  pipeline_id = heroku_pipeline.development.id
  org_repo    = "PinkUnicornLabs/lokr-room-api"
}

// Add Heroku app GitHub integration.
resource "herokux_app_github_integration" "development" {
  app_id      = heroku_app.dev_api.id
  branch      = "dev"
  auto_deploy = true
  wait_for_ci = true

  # Tells Terraform that this resource must be created/updated
  # only after the `herokux_pipeline_github_integration` has been successfully applied.
  depends_on = [herokux_pipeline_github_integration.development]
}


// Building
resource "heroku_build" "development" {
  app_id     = heroku_app.dev_api.id
  buildpacks = heroku_app.dev_api.buildpacks

  source {
    url = "https://github.com/PinkUnicornLabs/lokr-room-api.git"
    #    version = "v2.1.1"
  }
}

resource "heroku_formation" "development" {
  app_id     = heroku_app.dev_api.id
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = ["heroku_build.development"]
}
