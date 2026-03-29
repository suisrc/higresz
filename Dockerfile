FROM golang:1.25-bookworm AS build

RUN apt update && apt install -y git make

WORKDIR /opt

RUN git clone --depth 1 -b release-2.2.0 https://github.com/alibaba/higress.git .
COPY patch .
RUN make build-linux

# higress-registry.us-west-1.cr.aliyuncs.com
# higress-registry.cn-hangzhou.cr.aliyuncs.com
FROM higress-registry.us-west-1.cr.aliyuncs.com/higress/higress:v2.2.0

COPY --from=build /opt/out/linux_amd64/higress /usr/local/bin/higress

USER 1337:1337
ENTRYPOINT ["/usr/local/bin/higress"]
