/*
 * Created Date: 15.01.2020
 * Author: Fabius Engel (fabius.engel@msg.group)
 * -----
 * Last Modified: 15.01.2020 12:11:57
 * Modified By: Fabius Engel (fabius.engel@msg.group)
 * -----
 * Copyright (c) 2020 msg nexinsure ag
 */

provider "helm" {
    version        = "~> 1.0.0"

    kubernetes {
      host                   = module.k8s.host
      client_certificate     = base64decode(module.k8s.client_certificate)
      client_key             = base64decode(module.k8s.client_key)
      cluster_ca_certificate = base64decode(module.k8s.cluster_ca_certificate)
      load_config_file       = false
  }
}

module "aks" {
    source = "../../jenkins_terraform_module"

}