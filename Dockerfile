FROM alpine
MAINTAINER Cell <maintainer.docker.cell@outer.systems>

RUN apk add --update --no-progress bash openssh &&\
	rm -rf /var/cache/apk/*
RUN echo "ListenAddress 127.0.0.1" >> /etc/ssh/sshd_config
COPY start.sh /

ENTRYPOINT ["/start.sh"]

