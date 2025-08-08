output "chart_name" {
  description = "Helm Chart Details"
  value       = "${var.chart_name}-${var.chart_version}"
}