.PHONY: build docker podman publish

version := latest
arch := linux/amd64,linux/arm64

build: docker


docker:
	docker build --platform $(arch) ./xyz-hub -t xyzmaps/xyz-hub
	docker build --platform $(arch) ./xyz-postgres -t xyzmaps/xyz-postgres

publish:
	docker push xyzmaps/xyz-hub:$(version)
	docker push xyzmaps/xyz-postgres:$(version)


podman:
	podman build --platform $(arch) ./xyz-hub -t xyzmaps/xyz-hub
	podman build --platform $(arch) ./xyz-postgres -t xyzmaps/xyz-postgres