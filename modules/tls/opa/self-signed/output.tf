output "key_pem" {
  value = "${tls_private_key.opa.private_key_pem}"
}

output "cert_pem" {
  value = "${tls_locally_signed_cert.opa.cert_pem}"
}

output "ca_cert_pem" {
  value = "${var.ca_cert_pem == "" ? join(" ", tls_self_signed_cert.opa_ca.*.cert_pem): var.ca_cert_pem}"
}
