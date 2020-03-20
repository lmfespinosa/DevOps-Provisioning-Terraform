provider "statuscake" {
  username = "statuscake_username"
  apikey   = "statuskey_apikey"
}
resource "statuscake_test" "google" {
  website_name = "google.com"
  website_url  = "www.google.com"
  test_type    = "HTTP"
  check_rate   = 300
  contact_id   = 12345
}
