tag?=marcopeg/gitpod-workspace-hasura
version?=v2.0.0-alpha.10

build:
	docker build -t ${tag}:${version} .
	docker build -t ${tag}:latest .

publish: build
	docker push ${tag}:${version}
	docker push ${tag}:latest

	