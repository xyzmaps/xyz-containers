.PHONY: build docker podman publish

version := latest
arch := linux/amd64,linux/arm64

build: docker

# build locally for docker
docker:
	docker build ./xyz-hub -t xyzmaps/xyz-hub
	docker build ./xyz-postgres -t xyzmaps/xyz-postgres

# publish multi-arch images to docker hub
publish:
	docker buildx create --name xyzbuilder --use
	docker buildx inspect --bootstrap
	docker buildx build --platform $(arch) xyzmaps/xyz-hub:$(version) -t xyzmaps/xyz-hub --push
	docker buildx build --platform $(arch) xyzmaps/xyz-postgres:$(version) -t xyzmaps/xyz-postgres --push

# build locally for podman
podman:
	podman build ./xyz-hub -t xyzmaps/xyz-hub
	podman build ./xyz-postgres -t xyzmaps/xyz-postgres