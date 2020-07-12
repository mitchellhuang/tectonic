resource "kubernetes_deployment" "opa_deploy" {
  metadata {
    name      = "opa"
    namespace = "opa"

    labels = {
      app = "opa"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "opa"
      }
    }

    template {
      metadata {
        name = "opa"

        labels = {
          app = "opa"
        }
      }

      spec {
        volume {
          name = "opa-server"

          secret {
            secret_name = "opa-server"
          }
        }

        container {
          name  = "opa"
          image = "openpolicyagent/opa:latest"
          args  = ["run", "--server", "--tls-cert-file=/certs/tls.crt", "--tls-private-key-file=/certs/tls.key", "--addr=0.0.0.0:443", "--addr=http://127.0.0.1:8181", "--log-format=json-pretty", "--set=decision_logs.console=true"]

          volume_mount {
            name       = "opa-server"
            read_only  = true
            mount_path = "/certs"
          }

          liveness_probe {
            http_get {
              path   = "/health"
              port   = "443"
              scheme = "HTTPS"
            }

            initial_delay_seconds = 3
            period_seconds        = 5
          }

          readiness_probe {
            http_get {
              path   = "/health?plugins&bundle"
              port   = "443"
              scheme = "HTTPS"
            }

            initial_delay_seconds = 3
            period_seconds        = 5
          }
        }

        container {
          name  = "kube-mgmt"
          image = "openpolicyagent/kube-mgmt:0.8"
          args  = ["--replicate-cluster=v1/namespaces", "--replicate=extensions/v1beta1/ingresses"]
        }
      }
    }
  }
}
