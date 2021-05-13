.PHONY: build publish run

IMAGE_NAME=mortbauer/thyme

build:
	docker build . --tag ${IMAGE_NAME}

publish:
	docker push ${IMAGE_NAME}

run:
	docker run --rm -it -e REACT_APP_API_ROOT=http://localhost:5000 -e PUBLIC_URL=http://localhost:3000 -p 3000:80 --name thyme-test ${IMAGE_NAME}

#  vim: set noexpandtab ts=2 sw=2 tw=0 :
