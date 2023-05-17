APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=gcr.io/devops-k8s-386316
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=$(shell dpkg --print-architecture)
IMAGE_NAME=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} \
	go build -v -o telebot -ldflags "-X=github.com/turb0bur/telebot/cmd.appVersion=${VERSION}"

linux:
	$(MAKE) build TARGETOS=linux

windows:
	$(MAKE) build TARGETOS=windows

macos:
	$(MAKE) build TARGETOS=darwin

arm:
	$(MAKE) build TARGETOS=arm64

image:
	docker build --build-arg TARGETOS=${TARGETOS} --build-arg TARGETARCH=${TARGETARCH} . -t ${IMAGE_NAME}

push:
	docker push ${IMAGE_NAME}

clean:
	rm -rf telebot
	docker rmi ${IMAGE_NAME}