# 说明

ingress-nginx 不在维护， 使用 higress 取代，增加了一种绕过 Ingress 跨空间方位其他命名空间的service的方式。

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  # annotations:
  #   higress.io/destination: service.default.svc.cluster.local:80
  name: xxx
  namespace: zzz
spec:
  ingressClassName: nginx
  rules:
    - host: xxx.zzz.local
      http:
        paths:
          - backend:
              # [svc]---[ns]: 借助 ingress -> envoy rules 转换，绕过 k8s 中 ingress 跨命名空间访问 service 的限制
              service: { name: service---default, port: {name: http} }
              # +annotations: higress.io/destination: service.default.svc.cluster.local:80
              # resource: { apiGroup: networking.higress.io, kind: McpBridge, name: default }
            pathType: Prefix
            path: /
```

在解析服务到 envoy proxy 过程中，实现通过 name 的命名规则简单绕过 Ingress 不能跨命名空间访问 Service 的限制。  
使用 ghcr.io/suisrc/higresz 替换 higress-controller 镜像

```sh
helm repo add higress.io https://higress.cn/helm-charts
helm install higress higress.io/higress -n higress-system --set global.ingressClass=nginx
# 执行完成后，替换镜像
# image: higress-registry.cn-hangzhou.cr.aliyuncs.com/higress/higress:2.2.0
# image: ghcr.nju.edu.cn/suisrc/higresz:v0.0.6
```