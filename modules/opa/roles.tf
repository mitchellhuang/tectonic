resource "kubernetes_cluster_role_binding" "opa_viewer_cluster_role_binding" {
  metadata {
    name = "opa-viewer"
  }

  subject {
    kind = "Group"
    name = "system:serviceaccounts:opa"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
}

resource "kubernetes_role" "opa_configmap_modifier_role" {
  metadata {
    name      = "configmap-modifier"
    namespace = "opa"
  }

  rule {
    api_groups = [""]
    verbs      = ["update", "patch"]
    resources  = ["configmaps"]
  }
}

resource "kubernetes_role_binding" "opa_configmap_modifier_role_binding" {
  metadata {
    name      = "opa-configmap-modifier"
    namespace = "opa"
  }

  subject {
    kind = "Group"
    name = "system:serviceaccounts:opa"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "configmap-modifier"
  }
}
