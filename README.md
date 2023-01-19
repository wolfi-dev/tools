# tools

Various tools, images, etc. to support the Wolfi OSS project

- [Images](#images)
  - [sdk](#sdk)
  - [wolfictl](#wolfictl)

## Images

### sdk

The [sdk](./images/sdk) image contains melange, apko,
and other tools such as Go needed to build these projects.

This image is also used by [dag](https://github.com/wolfi-dev/dag)
to build Wolfi packages for ARM etc.

```
ghcr.io/wolfi-dev/sdk:latest
```

### wolfi

The [wolfictl](./images/wolfictl) image contains
[wolfictl](https://github.com/wolfi-dev/wolfictl).

```
ghcr.io/wolfi-dev/wolfictl:latest
```
