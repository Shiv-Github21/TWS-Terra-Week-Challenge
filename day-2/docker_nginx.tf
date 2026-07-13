resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx-conainer"{
    name  = var.container_name
    image = docker_image.nginx.image_id
    ports {
        internal = 80
        external = var.external_port
    }
}
