tag?=marcopeg/gitpod-workspace-hasura
version?=0.0.1

build:
	docker build -t ${tag}:${version} .
	docker build -t ${tag}:latest .

publish: build
	docker push ${tag}:${version}
	docker push ${tag}:latest

	