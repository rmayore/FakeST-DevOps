resource "aws_route53_record" "a_record" {
  zone_id = var.zone_id
  name    = var.zone_name
  type    = "A"
  ttl     = 300
  records = [var.eip]
}
