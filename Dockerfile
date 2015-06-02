FROM gcr.io/google_containers/skydns:2015-03-11-001
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin

COPY ./start /opt/bin/start
RUN chmod a+x /opt/bin/start

# Why is this at / ?
RUN mv /skydns /opt/bin/skydns

# Run the boot script
ENTRYPOINT /opt/bin/start
