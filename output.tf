output "app_url" {
  value       = heroku_app.staging.web_url
  description = "Application URL"
}
