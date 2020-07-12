resource "kubernetes_secret" "opa_server_secret" {
  metadata {
    name = "opa-server"
    namespace = "opa"
  }

  data = {
    "tls.crt" = "${var.cert_pem}"
    "tls.key" = "${var.key_pem}"
  }

  type = "kubernetes.io/tls"
}
