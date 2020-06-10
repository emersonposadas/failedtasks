#
# Authentication and credentials are stored on $HOME/.kube/config
#
provider "kubernetes" {}

resource "kubernetes_pod" "master" {
  metadata {
    name = "master"
    labels = {
      App         = "master-app"
      Owner       = "ops"
      Product     = "example-app"
      Environment = "dev"
    }
  }

  spec {
    container {
      image = "web-application-build"
      name  = "example"
    }
  }
}
