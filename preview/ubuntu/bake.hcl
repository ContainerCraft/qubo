# https://docs.docker.com/engine/reference/commandline/buildx_bake
# FLAG=$(git rev-parse --short HEAD) docker buildx bake --file ubuntu/bake.hcl

variable "FLAG" {
  default = "dev"
}

group "default" {
  targets = ["ubuntu"]
}

group "ubuntu" {
  targets = ["ubuntu-18.04", "ubuntu-20.04", "ubuntu-21.10"]
}

group "fedora" {
  targets = ["fedora-34", "fedora-35"]
}

group "centos-stream" {
  targets = ["centos-stream-8", "centos-stream-9"]
}

target "defaults" {
  dockerfile = "Containerfile"
  platforms = ["linux/amd64"]
}

target "ubuntu-defaults" {
  inherits = ["defaults"]
  args = {
    FLAVOR = "ubuntu",
  }
}

target "fedora-defaults" {
  inherits = ["defaults"]
  args = {
    FLAVOR = "fedora",
  }
}

target "centos-stream-defaults" {
  inherits = ["defaults"]
  args = {
    FLAVOR = "centos-stream",
  }
}

target "ubuntu-18.04" {
  inherits = ["ubuntu-defaults"]
  tags = [
    "docker.io/containercraft/ubuntu:18.04-${FLAG}",
    "docker.io/containercraft/ubuntu:bionic-${FLAG}"
  ]
}

target "ubuntu-20.04" {
  inherits = ["ubuntu-defaults"]
  tags = [
    "docker.io/containercraft/ubuntu:20.04-${FLAG}",
    "docker.io/containercraft/ubuntu:focal-${FLAG}"
  ]
}

target "ubuntu-21.10" {
  inherits = ["ubuntu-defaults"]
  tags = [
    "docker.io/containercraft/ubuntu:21.10-${FLAG}",
    "docker.io/containercraft/ubuntu:impish-${FLAG}"
  ]
}

target "fedora-34" {
  inherits = ["fedora-defaults"]
  tags = [
    "docker.io/containercraft/fedora:34-${FLAG}",
  ]
}

target "fedora-35" {
  inherits = ["fedora-defaults"]
  tags = [
    "docker.io/containercraft/fedora:35-${FLAG}",
  ]
}

target "arch" {
  inherits = ["defaults"]
  tags = [
    "docker.io/containercraft/arch:latest-${FLAG}",
  ]
}

target "centos-stream-8" {
  inherits = ["centos-stream-defaults"]
  tags = [
    "docker.io/containercraft/centos-stream:8-${FLAG}",
  ]
}

target "centos-stream-9" {
  inherits = ["centos-stream-defaults"]
  tags = [
    "docker.io/containercraft/centos-stream:9-${FLAG}",
  ]
}
