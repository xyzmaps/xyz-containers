# XYZ maps - containers

## Deploying

Checkout the repo or just download or copy&paste the `compose.yml` file to deploy a simple XYZ maps setup
including the hub service, the backend postgres database, redis caching and 
swagger ui for access to the REST service interface.

The postgres data is persisted locally in a newly created directory called `data` even if the stack is pulled down completely (normally just starting/stopping the stack should be enough).

## Images

Container images for arm64 and amd64 are on [Docker Hub](https://hub.docker.com/u/xyzmaps) if you would just like to run it.

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

Documentation: http://localhost:9000/

REST service: http://localhost:8080/hub

Swagger UI: http://localhost:8888/

Redoc UI: http://localhost:8889/

## Authentication

The xyz-hub REST service now uses [trantorHub](https://github.com/olifink/trantorHub) as an authenticating gateway.
That means you have to pass a JWT bearer token to interact with hub services.

The users are configured in `xyz-gateway/users.txt` in a `htpasswd` compatible format using *bcrypt* encrypted passwords.

Use this request to get a token from the service

    curl -X POST --location "http://localhost:8080/token" \
    -H "Content-Type: application/json" \
    -d '{
    "username": "user",
    "password": "uR_p4ssw0rd"
    }'

To use the `xyzmaps` [CLI](https://github.com/xyzmaps/xyz-cli) you have to put the token in
your local `.xyzcli` configuration file:

    {
        "hubApi": "http://localhost:8080/hub",
        "token": "(very_long_token_from_token_response)"
    }

The trantorHub service is configured via `xyz-gateway/config.json`. It's quite rudimentary at the moment,
but it gets the job done - provided of course, that you're exposing all endpoints via HTTPS(!) with something
like [Caddy](https://caddyserver.com), have a look at this [how to configure it](https://memos.mountmerlin.com/m/U6hRmodcfCB6AnpchXiohN#comments).

### Authorization

Currently, there is no user level access control passed into xyz-hub, meaning each authenticated is authorized
for full access to xyz-hub and can then access all spaces. There is no user-level separation of spaces yet, also there
are no fine-grained access controls to objects in spaces.

## Documentation (WIP)

More information and documentation

https://xyzmaps.github.io/xyz-documentation/


## Build it

The `Makefile` is available for building locally if needed. It uses the `Dockerfile`s in their respective directories.

`xyz-hub/Dockerfile` uses a builder pattern that uses a build-stage to check out and build the `xyzmaps/xyz-hub` project using maven. Only the resulting artifact is the used in the deployment image, so that there is no need to run the maven build locally.