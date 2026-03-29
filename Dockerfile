FROM golang:1.25-bookworm AS build

RUN apt update && apt install -y git make

WORKDIR /opt

RUN git clone --depth 1 -b release-2.2.0 https://github.com/alibaba/higress.git .
COPY patch .
RUN make build-linux

FROM higress-registry.cn-hangzhou.cr.aliyuncs.com/higress/base:latest-amd64

COPY --from=build out/linux_amd64/higress /usr/local/bin/higress

USER 1337:1337
ENTRYPOINT ["/usr/local/bin/higress"]
