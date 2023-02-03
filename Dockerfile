FROM busybox AS build-stage

WORKDIR /tmp

RUN wget http://api.build.openkylin.top/devel/openkylin/yangtze/amd64/chroot_url && \
    cat chroot_url | xargs wget -O openkylin-yangtze.tar.bz2 && \
    tar xjf openkylin-yangtze.tar.bz2

COPY etc/. chroot-autobuild/etc/

FROM scratch

MAINTAINER "Feng Jiang <jiangfeng@kylinos.cn>

COPY --from=build-stage /tmp/chroot-autobuild/. /

#RUN apt-get -y update && apt-get -y dist-upgrade

CMD ["/bin/bash"]
