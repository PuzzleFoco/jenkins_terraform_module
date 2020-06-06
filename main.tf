resource "kubernetes_namespace" "jenkins_namespace" {
    metadata {
        annotations = {
            name = "jenkins"
        }
        name = "jenkins"
    }
}

resource "kubernetes_service_account" "jenkins_service_account"{
  metadata {
    name = "jenkins-service-account"
  }
  automount_service_account_token = var.automount_service_account_token
}

resource "kubernetes_cluster_role_binding" "jenkins_service_account_binding" {
  metadata {
    name = "jenkins_service_account_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.jenkins_service_account.metadata[0].name
    namespace = kubernetes_service_account.jenkins_service_account.metadata[0].namespace
  }
}

data "kubernetes_secret" "jenkins_service_account_secret" {
  metadata {
    name = kubernetes_service_account.jenkins_service_account.default_secret_name
  }
}

locals {

    values_yaml_rendered = templatefile("${path.module}/values.yaml.tpl",{
        master          = var.master,
        agent           = var.agent,
        credentials     = var.credentials,
        secret_strings  = [
                            {
                            "id" : "${kubernetes_service_account.jenkins_service_account.metadata[0].name}"
                            "description" : ""
                            "secret" : "${lookup(data.kubernetes_secret.jenkins_service_account_secret.data, "token")}"
                            }
                        ],
        host_name       = var.host_name
    })
}

resource "helm_release" "jenkins"{
    name        = "jenkins"
    namespace   = kubernetes_namespace.jenkins_namespace.metadata[0].name
    chart       = "stable/jenkins"
    version     = "1.7.1"
    timeout     = 600

    values = [local.values_yaml_rendered]

    set {
        name = "master.adminPassword"
        value = "test123"
    }
}