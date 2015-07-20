FROM debian:8.1

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

ENV DEBIAN_FRONTEND noninteractive
ENV RANCHER_COMPOSE_VERSION v0.1.3

RUN apt-get update -q \
	&& apt-get install -y -q --no-install-recommends curl ca-certificates tar wget \
	&& wget -O /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz "https://github.com/rancher/rancher-compose/releases/download/${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz" \
	&& tar -xf /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz -C /tmp \
	&& mv /tmp/rancher-compose-${RANCHER_COMPOSE_VERSION}/rancher-compose /usr/local/bin/rancher-compose \
	&& rm -R /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz /tmp/rancher-compose-${RANCHER_COMPOSE_VERSION}\
	&& chmod +x /usr/local/bin/rancher-compose

# This container is a chrooted rancher-compose
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/rancher-compose"]
CMD ["--version"]

