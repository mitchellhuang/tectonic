module "opa" {
  source   = "../../modules/opa"
}

provider "kubernetes" {
  load_config_file       = false

  host                   = "${module.tectonic.kube_apiserver_url}"
  client_certificate     = "${module.kube_certs.apiserver_cert_pem}"
  client_key             = "${module.kube_certs.apiserver_key_pem}"
  cluster_ca_certificate = "${module.kube_certs.ca_cert_pem}"
}
