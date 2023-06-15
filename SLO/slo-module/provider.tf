terraform {
  required_version = "~> 1.2"

  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = ">= 1.20.0"
    }
  }
}
provider "dynatrace" {
  dt_env_url   = var.dynatrace_url
  dt_api_token = var.dynatrace_api_token
  alias = "dynatrace_api"
}
