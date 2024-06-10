.PHONY: build docker podman publish publish-init publish-build publish-cleanup

arch := linux/amd64,linux/arm64

build: docker

# build locally for docker
docker:
	docker build --no-cache ./xyz-hub -t xyzmaps/xyz-hub
	docker build --no-cache ./xyz-postgres -t xyzmaps/xyz-postgres
	docker build --no-cache ./xyz-docs -t xyzmaps/xyz-docs
	docker build --no-cache ./xyz-gateway -t xyzmaps/xyz-gateway

# publish multi-arch images to docker hub
publish: publish-init publish-build publish-cleanup

publish-init:
	docker buildx create --platform $(arch) --name xyzbuilder --use
	docker buildx inspect --bootstrap
	
publish-build:
	docker buildx build --platform $(arch) ./xyz-hub -t xyzmaps/xyz-hub --push
	docker buildx build --platform $(arch) ./xyz-postgres -t xyzmaps/xyz-postgres --push
	docker buildx build --platform $(arch) ./xyz-docs -t xyzmaps/xyz-docs --push
	docker buildx build --platform $(arch) ./xyz-gateway -t xyzmaps/xyz-gateway --push

publish-cleanup:
	docker context use default
	docker buildx stop xyzbuilder
	docker buildx rm xyzbuilder


# build locally for podman
podman:
	podman build ./xyz-hub -t xyzmaps/xyz-hub
	podman build ./xyz-postgres -t xyzmaps/xyz-postgres
	podman build ./xyz-docs -t xyzmaps/xyz-docs
	podman build ./xyz-gateway -t xyzmaps/xyz-gateway