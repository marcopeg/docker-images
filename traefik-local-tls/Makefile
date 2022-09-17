all: run

name ?= traefik-local-tls
registry ?= marcopeg
version ?= v2.8

image:
	$(call blue, "Building docker image...")
	docker build --no-cache -t ${name}:${version} -f Dockerfile .
	docker tag ${name}:${version} ${name}:latest
	$(MAKE) clean

run: image
	$(call blue, "Running Docker image locally...")
	docker run -i -t --rm -p 8080:8080 ${name}:${version} 

publish: image
	$(call blue, "Publishing Docker image to registry...")
	docker tag ${name}:${version} ${registry}/${name}:${version}
	docker tag ${name}:${version} ${registry}/${name}:latest
	docker push ${registry}/${name}:${version} 
	docker push ${registry}/${name}:latest

clean: 
	@rm -f app 

define blue
	@tput setaf 6
	@echo $1
	@tput sgr0
endef