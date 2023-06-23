# XYZ maps - containers

## Deploying

Checkout the repo or just download or copy&paste the `compose.yml` file to deploy a simple XYZ maps setup
including the hub service, the backend postgres database, redis caching and 
swagger ui for access to the REST service interface.

The postgres data is persisted locally in a newly created directory called `data` even if the stack is pulled down completely (normally just starting/stopping the stack should be enough).

## Images

The images are available on [Docker Hub](https://hub.docker.com/u/xyzmaps) so therre is no need to build locally if you just want to run it.

### Run using docker

In the directory where `compose.yml` is located run

```
docker compose up -d
```

### Run using podman

In the directory where `compose.yml` is located run

```
compose up -d
```

## Try it

Once the stack is up, the following URLs should work:

Swagger UI: http://localhost:8888/

REST endpoint: http://localhost:8080/hub 

## Documentation (WIP)

More information and documentation

https://xyzmaps.github.io/xyz-documentation/


## Build it

The `Makefile` is available for building locally if needed. It uses the `Dockerfile`s in their respective directories.

`xyz-hub/Dockerfile` uses a builder pattern that uses a build-stage to check out and build the `xyzmaps/xyz-hub` project using maven. Only the resulting artifact is the used in the deployment image, so that there is no need to run the maven build locally.