# gcc-musl Development

This doc covers building the gcc-musl image locally with apko, and using it with Docker.

## Building -musl Locally

First build the image first using apko:
```
apko build apko.yaml gcc-musl:devel gcc-musl.tar
```

Next, load the image from the tarball:
```
docker load < gcc-musl.tar
```

Try building something:
```
docker run --rm -v "${PWD}:/work" -w /work/examples/hello \
    gcc-musl:devel main.c -o /work/hello
```

Finally, try running it:
```
docker run --rm -v "${PWD}:/work" --entrypoint /work/hello \
    gcc-musl:devel
```
