terraform {
  required_version = "~> 1.2"

  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = ">= 1.20.0"
    }
  }
}
