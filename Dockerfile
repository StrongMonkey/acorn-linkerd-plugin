FROM golang:1.19 AS build
COPY / /src
WORKDIR /src
RUN --mount=type=cache,target=/go/pkg --mount=type=cache,target=/root/.cache/go-build make build

FROM alpine:3.16 AS base
RUN apk add --no-cache ca-certificates
RUN adduser -D acorn
USER acorn
ENTRYPOINT ["/usr/local/bin/linkerd-plugin"]
COPY --from=build /src/bin/linkerd-plugin /usr/local/bin/