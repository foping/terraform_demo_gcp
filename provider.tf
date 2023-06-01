provider "google" {
  credentials = file("service-account.json")
  project     = "terraformjlt"
  region      = "us-west1"
  zone        = "us-west1-b"
}