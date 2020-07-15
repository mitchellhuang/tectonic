data "kubernetes_namespace" "opa_namespace" {
  metadata {
    name = "opa"
    labels = {
      "openpolicyagent.org/webhook" = "ignore"
    }
  }
}

data "kubernetes_namespace" "kube_system_namespace" {
  metadata {
    name = "kube-system"
    labels = {
      "openpolicyagent.org/webhook" = "ignore"
    }
  }
}
