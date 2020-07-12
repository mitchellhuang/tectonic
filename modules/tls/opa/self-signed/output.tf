output "key_pem" {
  value = "${tls_private_key.opa.private_key_pem}"
}

output "cert_pem" {
  value = "${tls_locally_signed_cert.opa.cert_pem}"
}
