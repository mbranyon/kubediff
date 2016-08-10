.PHONY: all clean lint
.DEFAULT_GOAL := all

all: .uptodate

IMAGE_VERSION := $(shell git rev-parse --abbrev-ref HEAD)-$(shell git rev-parse --short HEAD)

.uptodate: prom-run Dockerfile
	docker build -t mbranyon/kubediff .
	docker tag mbranyon/kubediff:latest mbranyon/kubediff:$(IMAGE_VERSION)

prom-run: vendor/github.com/tomwilkie/prom-run/*.go
	CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o $@ ./vendor/github.com/tomwilkie/prom-run

lint:
	flake8 kubediff

clean:
	rm -f prom-run .uptodate
