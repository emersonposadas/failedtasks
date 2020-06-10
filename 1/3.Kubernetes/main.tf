#
# Assumptions:
# - Authentication and credentials are stored on $HOME/.kube/config
# - minikube is already started ($ minikube start)
# - Virtualbox is alredy installed
# - vt-x CPU extensions are enabled on the BIOS
# - $ terraform init is already run
# - $ terraform apply to provision the cluster
#

provider "kubernetes" {}

resource "kubernetes_namespace" "one" {
  metadata {
    annotations = {
      name = "coolcompany"
    }

    labels = {
      region = "coolcompany"
    }

    name = "coolcompany"
  }
}

resource "kubernetes_deployment" "web-app" {
  metadata {
    name = "web-application"
    labels = {
      test = "web-application"
    }
    namespace = "coolcompany"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "web-application"
      }
    }

    template {
      metadata {
        labels = {
          test = "web-application"
        }
      }

      spec {
        container {
          port {
            container_port = "80"
          }
          image = "httpd"
          name  = "web-application"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "web-app"
    namespace = "coolcompany"
  }
  spec {
    selector = {
      name = "coolcompany"
    }
    session_affinity = "ClientIP"
    port {
      port        = 1337
      target_port = 80
    }

    type = "NodePort"
  }
}
