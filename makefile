.PHONY: start build

NOW = $(shell date -u '+%Y%m%d%I%M%S')
APP = $(shell cat vname)

sync:
	mkdir -p ./patch/pkg/ingress/kube/ingressv1
	cp ../higress/pkg/ingress/kube/ingressv1/controller.go ./patch/pkg/ingress/kube/ingressv1/controller.go

git:
	@if [ -z "$(tag)" ]; then \
		echo "error: 'tag' not specified! Please specify the 'tag' using 'make tflow tag=(version)'";\
		exit 1; \
	fi
	git tag -a $(tag) -m "${tag}" && git push origin $(tag)
