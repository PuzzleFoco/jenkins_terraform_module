variable "master" {
    type = any
    default = {
        "numExecutors": "2",
    }
}

variable "agent" {
    type = any
    default = {
        "enabled": "true",
        "image": "getintodevops/jenkins-withdocker",
        "tag": "lts-docker19.03.5"
        "alwaysPullImage" : "true"
    }
}