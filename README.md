# Bulb

A tool for building minimum sysroots for OCI containers with an executable as the seed.

## Examples

Dockerfile: Build minimum curl container image for arm64 using curl executable as the seed.

1. Create dockerfile

```sh
cat >>Dockerfile <<END
FROM erikja/bulb:0.1.0 AS acquire-exe
ARG EXPORT_DIR
ARG ARCH=arm64
RUN install -d $EXPORT_DIR
RUN install-pkgs -a $ARCH -r $EXPORT_DIR curl

FROM erikja/bulb:0.1.0 AS build
ARG EXPORT_DIR
ARG ARCH=amd64
RUN install -d $EXPORT_DIR
COPY --from=acquire-exe $EXPORT_DIR/usr/bin/curl /tmp/curl
RUN build-sysroot -m -o $EXPORT_DIR /tmp/curl

FROM scratch
ARG EXPORT_DIR
COPY --from=build $EXPORT_DIR /
ENTRYPOINT ["/usr/bin/curl"]
END
```

2. Build image

```sh
docker build -t curl .
```

Command line: Create the minimum curl sysroot amd64 using curl executable as the seed.

```sh
host_workdir=/tmp/workdir
workdir=/workdir
mkdir -p $host_workdir
cd $host_workdir
mkdir sysroot
container_id=$(docker run -d badouralix/curl-jq:debian)
docker cp $container_id:/usr/bin/curl .
docker run -v $host_workdir:$workdir -w $workdir erikja/bulb:0.1.0 -m -o $workdir/sysroot curl
docker rm $container_id
```
