resource "tls_private_key" "opa_ca" {
  count = "${var.ca_cert_pem == "" ? 1 : 0}"

  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "opa_ca" {
  count = "${var.ca_cert_pem == "" ? 1 : 0}"

  key_algorithm   = "${tls_private_key.opa_ca.algorithm}"
  private_key_pem = "${tls_private_key.opa_ca.private_key_pem}"

  subject {
    common_name  = "admission_ca"
  }

  is_ca_certificate     = true
  validity_period_hours = "${var.validity_period}"

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}
