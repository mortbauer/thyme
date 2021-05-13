.PHONY: build publish run build-dev run-dev

IMAGE_NAME=mortbauer/thyme
IMAGE_NAME_DEV=mortbauer/thyme-dev

build:
	docker build . --tag ${IMAGE_NAME}

build-dev:
	docker build . --tag ${IMAGE_NAME_DEV} --target base

publish:
	docker push ${IMAGE_NAME}

run:
	docker run --rm -it -e REACT_APP_API_ROOT=http://localhost:5000 -e PUBLIC_URL=http://localhost:3000 -p 3000:80 --name thyme-test ${IMAGE_NAME}

run-dev:
	docker run --rm -it  -p 3000:3000 -v ${PWD}/src:/app/src --name thyme-dev ${IMAGE_NAME_DEV} npm start

#  vim: set noexpandtab ts=2 sw=2 tw=0 :
