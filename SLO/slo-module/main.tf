locals {
  json_files = fileset("${path.module}/solutions", "*/*.json")
  solutions = {
    for filename in local.json_files :
    "${jsondecode(file("${path.module}/solutions/${filename}"))["solution_name"]}-${jsondecode(file("${path.module}/solutions/${filename}"))["environment"]}" => jsondecode(file("${path.module}/solutions/${filename}"))
  }
  slo = [for solution in local.solutions : {
    for slo in solution.slo : "${solution.sre_team}-${solution.product_id}-${solution.solution_name}-${solution.environment}" => {
      product_management_zone = try(solution.product_management_zone, null)
      slo_target              = try(solution.slo[0].slo_target, "98")
      slo_warning             = try(solution.slo[0].slo_warning, "99")
    } if try(solution.slo, null) != null
  }]
  slos_flattened = merge([for solution in local.slo : solution]...)
}

module "sre-central-slo" {
  source = "../"
  for_each          = local.slos_flattened

  slo_name          = "${each.key}-slo"
  evaluation        = "AGGREGATE"
  filter_name       = each.value.product_management_zone != null ? "type(SYNTHETIC_TEST),entityName.startsWith(\"${each.key}\"),mzName(\"${each.value.product_management_zone}\", \"${var.default_mz_name}\")" : "type(SYNTHETIC_TEST),entityName.startsWith(\"${each.key}\"),mzName(\"${var.default_mz_name}\")" 
  metric            = "(builtin:synthetic.browser.availability.location.total:splitBy())"
  slo_target        = each.value.slo_target
  slo_warning       = each.value.slo_warning
  timeframe         = "-1w"
}
