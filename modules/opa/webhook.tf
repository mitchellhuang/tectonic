resource "kubernetes_manifest" "opa_validating_webhook_configuration" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1beta1"
    "kind" = "ValidatingWebhookConfiguration"
    "metadata" = {
      "name" = "opa-validating-webhook"
    }
    "webhooks" = [
      {
        "clientConfig" = {
          "caBundle" = filebase64("${var.ca_cert_pem}")
          "service" = {
            "name" = "opa"
            "namespace" = "opa"
          }
        }
        "name" = "validating-webhook.openpolicyagent.org"
        "namespaceSelector" = {
          "matchExpressions" = [
            {
              "key" = "openpolicyagent.org/webhook"
              "operator" = "NotIn"
              "values" = [
                "ignore",
              ]
            },
          ]
        }
        "rules" = [
          {
            "apiGroups" = [
              "*",
            ]
            "apiVersions" = [
              "*",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "*",
            ]
          },
        ]
      },
    ]
  }
}
