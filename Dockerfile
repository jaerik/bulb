FROM debian:bookworm-slim
ENV BOLB_SH_UTILS=/usr/lib/utils.sh
RUN apt-get update \
 && apt-get install -yf --no-install-recommends \
        apt-file  \
        equivs \
        file \
        libc6-amd64-cross \
        libc6-arm64-cross \
        libc6-armhf-cross \
 && apt-get clean

RUN ln -sf /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1 \
 && ln -sf /usr/arm-linux-gnueabihf/lib/ld-linux-armhf.so.3 /lib/ld-linux-armhf.so.3

ADD dpkg-empty.tar /var/lib/dpkg-empty
COPY build-sysroot install-pkgs ld-trace /usr/bin/
COPY utils.sh $BOLB_SH_UTILS
ENTRYPOINT ["build-sysroot"]
