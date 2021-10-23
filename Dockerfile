# syntax=docker/dockerfile:
FROM jc21/nginx-proxy-manager:latest
RUN apt-get update \
        && apt-get install iptables -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

COPY iptables.rules /iptables.rules
RUN mkdir /etc/services.d/iptables/ -p
COPY run /etc/services.d/iptables/run
RUN chmod 777 /etc/services.d/iptables/run

VOLUME [ "/data", "/etc/letsencrypt" ]
ENTRYPOINT [ "/init" ]