// Create an app.
resource "heroku_app" "staging" {
  name   = "terraform-alcho-bot"
  region = "eu"
}

// Create a pipeline.
resource "heroku_pipeline" "foobar" {
  name = "stage-pipeline"
}

# Couple app to pipeline.
resource "heroku_pipeline_coupling" "staging" {
  app      = heroku_app.staging.name
  pipeline = heroku_pipeline.foobar.id
  stage    = "staging"
}

// Add the GitHub repository integration with the pipeline.
resource "herokux_pipeline_github_integration" "foobar" {
  pipeline_id = heroku_pipeline.foobar.id
  org_repo    = "skarppion101/sabir-alcho-bot"
}

// Add Heroku app GitHub integration.
resource "herokux_app_github_integration" "foobar" {
  app_id      = heroku_app.staging.uuid
  branch      = "master"
  auto_deploy = true
  wait_for_ci = true

  # Tells Terraform that this resource must be created/updated
  # only after the `herokux_pipeline_github_integration` has been successfully applied.
  depends_on = [herokux_pipeline_github_integration.foobar]
}
