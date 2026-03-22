FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache curl bash

# Качаем sing-box (он чище и быстрее для Choreo)
RUN curl -L https://github.com/SagerNet/sing-box/releases/download/v1.8.5/sing-box-1.8.5-linux-amd64.tar.gz -o /tmp/sb.tar.gz && \
    tar -xvf /tmp/sb.tar.gz -C /tmp && \
    mv /tmp/sing-box-*/sing-box /usr/local/bin/sing-box && \
    rm -rf /tmp/*

# Создаем папку для конфига
RUN mkdir -p /etc/sing-box

# Копируем конфиг
COPY config.json /etc/sing-box/config.json

# Настройка пользователя для Choreo
RUN addgroup -S sbgroup && adduser -S sbuser -G sbgroup -u 10014
RUN chown -R sbuser:sbgroup /etc/sing-box /usr/local/bin/sing-box

USER 10014

EXPOSE 8080

# Запуск sing-box
CMD ["/usr/local/bin/sing-box", "run", "-c", "/etc/sing-box/config.json"]
