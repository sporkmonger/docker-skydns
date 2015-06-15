FROM quay.io/sporkmonger/go
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin

COPY ./start /opt/bin/start
RUN chmod a+x /opt/bin/start

# Note: This needs at least 1GB to compile. 512MB will exit w/ OOM.
RUN go get github.com/skynetservices/skydns && \
  CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags '-w' github.com/skynetservices/skydns && \
  mv /go/bin/skydns /opt/bin/skydns

# Run the boot script
ENTRYPOINT /opt/bin/start
