tag?=marcopeg/gitpod-workspace-postgis
version?=0.0.0

test:
	docker build -t ${tag}:${version} --no-cache .

build:
	docker build -t ${tag}:${version} .

publish:
	docker build -t ${tag}:${version} .
	docker build -t ${tag}:latest .
	docker push ${tag}:${version}
	docker push ${tag}:latest

	