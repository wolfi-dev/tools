# tools

Various tools, images, etc. to support the Wolfi OSS project

- [Images](#images)
  - [sdk](#sdk)
  - [apko](#apko)
  - [melange](#melange)
  - [wolfictl](#wolfictl)

## Images

### sdk

The [sdk](./images/sdk) image contains melange, apko,
wolfictl and other tools such as Go needed to build these projects.

This image is also used by [dag](https://github.com/wolfi-dev/dag)
to build Wolfi packages for ARM etc.

```
ghcr.io/wolfi-dev/sdk:latest
```

### apko

The [apko](./images/apko) image contains
[apko](https://github.com/chainguard-dev/apko).

```
ghcr.io/wolfi-dev/apko:latest
```

### melange

The [melange](./images/melange) image contains
[melange](https://github.com/chainguard-dev/melange).

```
ghcr.io/wolfi-dev/melange:latest
```

### wolfi-base

The [wolfi-base](./images/wolfi-base) image contains
the `wolfi-base` package (which provides `busybox` and `apk`).

on Docker Hub:
```
wolfios/wolfi-base:latest
```

on GHCR:
```
ghcr.io/wolfi-dev/wolfi-base:latest
```

### wolfictl

The [wolfictl](./images/wolfictl) image contains
[wolfictl](https://github.com/wolfi-dev/wolfictl).

```
ghcr.io/wolfi-dev/wolfictl:latest
```
