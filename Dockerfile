FROM alpine
MAINTAINER Mathew Branyon <mbranyon@zvelo.com>
RUN apk update && \
   apk add py-yaml curl && \
   curl -o /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/linux/amd64/kubectl && \
   chmod u+x /bin/kubectl
WORKDIR /
COPY prom-run kubediff /
EXPOSE 80
ENTRYPOINT ["/prom-run"]
