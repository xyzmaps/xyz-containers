# Use a base image with git installed
FROM alpine/git as clone-stage

WORKDIR /app

# Clone your repository
RUN git clone https://github.com/olifink/trantorHub.git .

# Build the application from source
FROM golang:1.22 AS build-stage

COPY --from=clone-stage /app /app

WORKDIR /app

RUN go build -v .

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian12 AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/trantorHub /trantorHub
COPY config.json /config.json
COPY users.txt /users.txt

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/trantorHub","-config","/config.json","-users","/users.txt]