variable "container_name" {
  description = "Name for the Docker container"
  type        = string
  default     = "nginx-container"
}
variable "nginx_image" {
  description = "Docker image for Nginx"
  type        = string
  default     = "nginx:latest"
}
variable "external_port"{
    description = "External port for the Docker container"
    type        = number
    default     = 8081
}