.PHONY: build docker podman publish

version := latest

build: docker

docker:
	docker build ./xyz-hub -t xyzmaps/xyz-hub
	docker build ./xyz-postgres -t xyzmaps/xyz-postgres

publish:
	docker push xyzmaps/xyz-hub:$(version)
	docker push xyzmaps/xyz-postgres:$(version)


podman:
	podman build ./xyz-hub -t xyzmaps/xyz-hub
	podman build ./xyz-postgres -t xyzmaps/xyz-postgres