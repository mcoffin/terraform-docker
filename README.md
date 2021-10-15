# terraform-docker

Bulids [Alpine Linux](https://alpinelinux.org/)-based [Terraform](https://terraform.io) images for Docker. While all dependencies are installed via `apk`, `terraform` itself is installed from signed tarballs shipped by hashicorp so that we can stay more up-to-date.

# Building

There is a `Makefile` included for ease of use. To build some terraform images, simply run the following.

```bash
make TF_VERSION=x.y.z
```

This will build the images locally, but not push them to [Docker Hub](https://hub.docker.com) automatically.
