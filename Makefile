.PHONY: build docker podman publish

version := latest
# arch := --platform linux/amd64,linux/arm64

build: docker


docker:
	docker build $(arch) ./xyz-hub -t xyzmaps/xyz-hub
	docker build $(arch) ./xyz-postgres -t xyzmaps/xyz-postgres

publish:
	docker push xyzmaps/xyz-hub:$(version)
	docker push xyzmaps/xyz-postgres:$(version)


podman:
	podman build $(arch) ./xyz-hub -t xyzmaps/xyz-hub
	podman build $(arch) ./xyz-postgres -t xyzmaps/xyz-postgres