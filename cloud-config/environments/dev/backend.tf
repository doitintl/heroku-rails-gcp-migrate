terraform {
  backend "gcs" {
    bucket = "my-project-tfstate"
    prefix = "env/dev"
  }
}