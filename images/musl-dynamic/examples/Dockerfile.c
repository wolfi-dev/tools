ARG BASE=ghcr.io/wolfi-dev/musl-dynamic

FROM ghcr.io/wolfi-dev/gcc-musl as build

COPY hello.c /work/hello.c
RUN cc hello.c -o hello

FROM $BASE

COPY --from=build /work/hello /hello
CMD ["/hello"]
