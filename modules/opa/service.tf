resource "kubernetes_service" "opa_service" {
  metadata {
    name      = "opa"
    namespace = "opa"
  }

  spec {
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = "443"
    }

    selector = {
      app = "opa"
    }
  }
}
