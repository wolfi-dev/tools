ARG BASE=ghcr.io/wolfi-dev/alpine-base

FROM golang:1.18@sha256:50c889275d26f816b5314fc99f55425fa76b18fcaf16af255f5d57f09e1f48da as build
WORKDIR /go/src/app
COPY . .
RUN go build -o /go/bin/app

FROM $BASE
COPY --from=build /go/bin/app /
CMD ["/app"]
