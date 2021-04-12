all: run

# marcopeg/postgres-backup-s3:0.0.1
name ?= postgres-backup-s3
registry ?= marcopeg
version ?= 0.0.1

build:
	$(call blue, "Building docker image (with cache)...")
	docker build -t ${name}:${version} -f Dockerfile .
	docker tag ${name}:${version} ${name}:latest
	$(MAKE) clean

image:
	$(call blue, "Building docker image...")
	docker build --no-cache -t ${name}:${version} -f Dockerfile .
	docker tag ${name}:${version} ${name}:latest
	$(MAKE) clean

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
