# 说明

ingress-nginx 不在维护， 使用 higress 取代，增加了一种绕过 Ingress 跨空间方位其他命名空间的service的方式。

```yaml
service:
  name: (service-name)---(namespace)
  port: ...
```

在解析服务到 envoy proxy 过程中，实现通过 name 的命名规则简单绕过 Ingress 不能跨命名空间访问 Service 的限制。  
使用 ghcr.io/suisrc/higresz 替换 higress-controller 镜像