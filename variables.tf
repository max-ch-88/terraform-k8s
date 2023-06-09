variable "name" {
  description = "Name of the namespace to be created"
  type        = string
}

variable "limit_cpu" {
  description = "CPU quota"
  type        = string
}

variable "limit_mem" {
  description = "Memory quota"
  type        = string
}

variable "kubectl_config_context_name" {
  description = "The config context to use when authenticating to the Kubernetes cluster. If empty, defaults to the current context specified in the kubeconfig file."
  type        = string
  default     = ""
}

variable "kubectl_config_path" {
  description = "The path to the config file to use for kubectl. If empty, defaults to $HOME/.kube/config"
  type        = string
  default     = "~/.kube/config"
}
