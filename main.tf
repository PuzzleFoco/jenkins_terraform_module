resource "helm_release" "jenkins"{
    name        = "jenkins"
    namespace   = "jenkins"
    chart       = "stable/jenkins"
    timeout     = 600
}