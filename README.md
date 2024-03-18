# tools

Various tools, images, etc. to support the Wolfi OSS project

- [Images](#images)
  - [alpine-base](#alpine-base)
  - [apko](#apko)
  - [busybox](#busybox)
  - [gcc-musl](#gcc-musl)
  - [git](#git)
  - [melange](#melange)
  - [musl-dynamic](#musl-dynamic)
  - [sdk](#sdk)
  - [static](#static)
  - [wolfictl](#wolfictl)

## Images

### alpine-base

The [alpine-base](./images/alpine-base) image is a minimal Alpine-based image containing `apk` and basic tools to get started.

```
ghcr.io/wolfi-dev/alpine-base:latest
```

### apko

The [apko](./images/apko) image contains [apko](https://github.com/chainguard-dev/apko).

```
ghcr.io/wolfi-dev/apko:latest
```

### busybox

The [busybox](./images/busybox) image contains [busybox](https://busybox.net/) built from Alpine's busybox package.

```
ghcr.io/wolfi-dev/busybox:alpine
```

It's intended as a replacement for `cgr.dev/chainguard/busybox:latest`.

### gcc-musl

The [gcc-musl](./images/gcc-musl) image contains a GCC toolchain built with musl libc from Alpine's packages.

```
ghcr.io/wolfi-dev/gcc-musl:latest
```

### git

The [git](./images/git) image contains [git](https://git-scm.com/) built from Alpine's git package.

```
ghcr.io/wolfi-dev/git:alpine
ghcr.io/wolfi-dev/git:alpine-root
```

It's intended as a replacement for `cgr.dev/chainguard/git:latest` and `cgr.dev/chainguard/git:latest-root`.

### melange

The [melange](./images/melange) image contains
[melange](https://github.com/chainguard-dev/melange).

```
ghcr.io/wolfi-dev/melange:latest
```

### musl-dynamic

The [musl-dynamic](./images/musl-dynamic) image contains a musl libc built from Alpine's packages.

```
ghcr.io/wolfi-dev/musl-dynamic:latest
```

### sdk

The [sdk](./images/sdk) image contains melange, apko, wolfictl and other tools such as Go needed to build these projects.

```
ghcr.io/wolfi-dev/sdk:latest
```

### static

The [static](./images/static) image contains a minimal static base image built from Alpine's packages.

```
ghcr.io/wolfi-dev/static:alpine
```

It's intended as a replacement for `cgr.dev/chainguard/static:latest`.

### wolfictl

The [wolfictl](./images/wolfictl) image contains
[wolfictl](https://github.com/wolfi-dev/wolfictl).

```
ghcr.io/wolfi-dev/wolfictl:latest
```
