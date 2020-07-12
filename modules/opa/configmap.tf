resource "kubernetes_config_map" "opa_default_system_main_configmap" {
  metadata {
    name      = "opa-default-system-main"
    namespace = "opa"
  }

  data = {
    main = "package system\n\nimport data.kubernetes.admission\n\nmain = {\n  apiVersion: admission.k8s.io/v1beta1,\n  kind: AdmissionReview,\n  response: response,\n}\n\ndefault response = {allowed: true}\n\nresponse = {\n    allowed: false,\n    status: {\n        reason: reason,\n    },\n} {\n    reason = concat(, , admission.deny)\n    reason != \n}\n"
  }
}
