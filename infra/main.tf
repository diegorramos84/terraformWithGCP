# Bucket to store website

resource "google_storage_bucket" "website" {
  name = "example-website-by-dieramos"
  location = "EU"
}

# Make new object public
resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_src.name
  bucket = google_storage_bucket.website.name
  role = "READER"
  entity = "allUsers"
}

# Upload the html file to the bucket
resource "google_storage_bucket_object" "static_site_src" {
  name ="index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name
}

# Reserve a static external IP address
resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip"
}
