module "service" {
  source = ".."

  url      = "https://us.gcr.io"
  username = "_json_key"
  email    = "invalid@example.com"
  password = "secret"
}
