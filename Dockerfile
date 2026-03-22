FROM alpine:latest
RUN apk add --no-cache curl bash unzip
RUN mkdir -p /etc/xray /usr/local/bin
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    rm /tmp/xray.zip
COPY config.json /etc/xray/config.json
# Choreo требует порт выше 1024, будем юзать 8080
EXPOSE 8080
CMD ["/usr/local/bin/xray", "-c", "/etc/xray/config.json"]
