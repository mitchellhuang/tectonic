# Kubelet
resource "tls_private_key" "opa" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "opa" {
  key_algorithm   = "${tls_private_key.opa.algorithm}"
  private_key_pem = "${tls_private_key.opa.private_key_pem}"

  subject {
    common_name  = "opa.opa.svc"
  }
}

resource "tls_locally_signed_cert" "opa" {
  cert_request_pem = "${tls_cert_request.opa.cert_request_pem}"

  ca_key_algorithm      = "${var.ca_key_alg}"
  ca_private_key_pem    = "${var.ca_key_pem}"
  ca_cert_pem           = "${var.ca_cert_pem}"
  validity_period_hours = "${var.validity_period}"

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}
