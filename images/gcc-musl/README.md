Minimal container image for building C applications (which do not require glibc).

## Get It!

The image is available on `cgr.dev`:

```
docker pull ghcr.io/wolfi-dev/gcc-musl:latest
```

## Usage

To build the C application in [examples/hello/main.c](https://github.com/chainguard-images/images/blob/main/images/gcc-glibc/examples/hello/main.c):

```
$ docker run --rm -v "${PWD}:/work" ghcr.io/wolfi-dev/gcc-musl examples/hello/main.c -o hello
```

This will write a Linux binary to `./hello`. If you're on Linux and have the musl library, you
should be able to run it directly. Otherwise you can run it in a container e.g:

```
$ docker run --rm -v "$PWD/hello:/hello" ghcr.io/wolfi-dev/musl-dynamic /hello
Hello World!
```

We can also do this all in a multi-stage Dockerfile e.g:

```Dockerfile
FROM ghcr.io/wolfi-dev/gcc-musl as build

COPY hello.c /work/hello.c
RUN cc hello.c -o hello

FROM ghcr.io/wolfi-dev/musl-dynamic

COPY --from=build /work/hello /hello
CMD ["/hello"]
```

And we can also compile statically to be used in environments without musl:


```Dockerfile
FROM ghcr.io/wolfi-dev/gcc-musl as build

COPY hello.c /work/hello.c
RUN cc --static hello.c -o hello

FROM cgr.dev/chainguard/static

COPY --from=build /work/hello /hello
CMD ["/hello"]
```
