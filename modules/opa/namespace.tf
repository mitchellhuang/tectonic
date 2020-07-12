data "kubernetes_namespace" "opa_namespace" {
  metadata {
    name = "opa"
  }
}
