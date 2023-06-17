variable "default_mz_name" {
  description = "SRE shared dynatrace Management Zone name"
  type        = string
  default     = "12284_CFC-Infra-Prod"
}

variable "slo_name" {
  description = "Slo Name"
  type = string
  default = ""
}

variable "evaluation" {
  description = "Slo Evaluation"
  type = string
  default = "AGGREGATE"
}

variable "filter_name" {
  description = "Slo Filter"
  type = string
  default = ""
}

variable "metric" {
  description = "Slo metric"
  type = string
  default = ""
}

variable "slo_target" {
  description = "Slo Target"
  type = string
  default = "95"
}

variable "slo_warning" {
  description = "Slo Warning"
  type = string
  default = "98"
}

variable "timeframe" {
  description = "Slo Timeframe"
  type = string
  default = ""
}
