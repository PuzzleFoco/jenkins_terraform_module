variable "master" {
    type = any
    default = {}
}

variable "credentials" {
    type    = list(any)
    default = []
}

variable "agent" {
    type = any
    default = {
        "enabled": "true",
        "image": "fabiuse/jenkins-with-docker",
        "tag": "latest"
        "alwaysPullImage" : "true"
    }
}

variable "host_name" {
    type = string
    default = ""
}

variable "automount_service_account_token" {
    description = "enable automatic mounting of the service account token"
    type        = bool
    default     = false
}