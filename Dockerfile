FROM quay.io/sporkmonger/go
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN apk add --update bind-tools && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/bin

# Note: This needs at least 1GB to compile. 512MB will exit w/ OOM.
RUN go get github.com/skynetservices/skydns && \
  CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags '-w' github.com/skynetservices/skydns && \
  mv /go/bin/skydns /opt/bin/skydns

# Note: This comes after the larger layer build to minimize impact from changes
# to the start script.
COPY ./start /opt/bin/start
RUN chmod a+x /opt/bin/start

# Run the boot script
CMD /opt/bin/start
