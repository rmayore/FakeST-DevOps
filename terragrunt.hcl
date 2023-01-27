remote_state {
  backend = "s3"
  config = {
    bucket  = "fake-st-terraform-state"
    key     = "terragrunted/${path_relative_to_include()}.tfstate"
    region  = "af-south-1"
    encrypt = true
  }
}
