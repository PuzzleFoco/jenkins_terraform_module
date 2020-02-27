locals {
    values_yaml_rendered = templatefile("${path.module}/values.yaml.tpl",{
        agent = var.agent
    })
}

resource "kubernetes_namespace" "jenkins_namespace" {
    metadata {
        annotations = {
            name = "jenkins"
        }
        name = "jenkins"
    }
}

resource "helm_release" "jenkins"{
    name        = "jenkins"
    namespace   = kubernetes_namespace.jenkins_namespace.metadata[0].name
    chart       = "stable/jenkins"
    version     = "1.9.19"
    timeout     = 600

    values = [locals.values_yaml_rendered]
}