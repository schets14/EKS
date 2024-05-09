resource "helm_release" "istio_base" {
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  namespace  = "istio-system"
  version    = "1.20.1" # Specify the version here

  set {
    name  = "global.istiod.enabled"
    value = "true"
  }
}

resource "helm_release" "istiod" {
  depends_on = [helm_release.istio_base]
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  namespace  = "istio-system"
  version    = "1.20.1" # Specify the version here
}

resource "helm_release" "istio-ingress" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  name       = "istio-ingress"
  namespace  = "istio-system"
  version    = "1.20.1"
  depends_on = [helm_release.istiod]
}
