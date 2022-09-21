output "app_url" {
  value       = heroku_app.dev_api.web_url
  description = "Dev API URL"
}
