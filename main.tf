resource "helm_release" "jenkins"{
    name        = "jenkins"
    namespace   = "jenkins"
    chart       = "stable/jenkins"
    version     = "1.7.1."
    timeout     = 600
}