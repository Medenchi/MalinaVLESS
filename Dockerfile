FROM alpine:latest
RUN apk add --no-cache curl bash unzip
RUN curl -L https://github.com/SagerNet/sing-box/releases/download/v1.11.1/sing-box-1.11.1-linux-amd64.tar.gz -o /tmp/sb.tar.gz && \
    tar -xvf /tmp/sb.tar.gz -C /tmp && \
    mv /tmp/sing-box-*/sing-box /usr/local/bin/sing-box && \
    rm -rf /tmp/*
COPY config.json /etc/sing-box/config.json
# Koyeb любит порт 8080
EXPOSE 8080
CMD ["/usr/local/bin/sing-box", "run", "-c", "/etc/sing-box/config.json"]
