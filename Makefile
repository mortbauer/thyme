.PHONY: build publish run

IMAGE_NAME=mortbauer/thyme

build:
	docker build . --tag ${IMAGE_NAME}

publish:
	docker push ${IMAGE_NAME}

run:
	docker run --rm -it -v $PWD/.env:/.env -v $PWD/src:/src -p 3000:3000 ${IMAGE_NAME}

#  vim: set noexpandtab ts=2 sw=2 tw=0 :
