resource "dynatrace_slo" "sre-central-slo" {
  name              = var.slo_name
  evaluation        = var.evaluation
  filter            = var.filter_name
  metric_expression = var.metric
  target            = var.slo_target
  warning           = var.slo_warning
  timeframe         = var.timeframe
}
