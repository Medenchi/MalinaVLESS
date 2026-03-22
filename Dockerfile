FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache curl bash unzip

# Создаем папку для xray и конфига
RUN mkdir -p /etc/xray /usr/local/bin

# Скачиваем и распаковываем xray
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    rm /tmp/xray.zip

# Копируем конфиг
COPY config.json /etc/xray/config.json

# --- ИСПРАВЛЕНИЕ ОШИБКИ БЕЗОПАСНОСТИ ---
# Создаем непривилегированного пользователя с ID 10014 (как просит Choreo)
RUN addgroup -S xraygroup && adduser -S xrayuser -G xraygroup -u 10014

# Даем права этому пользователю на работу с файлами
RUN chown -R xrayuser:xraygroup /etc/xray /usr/local/bin/xray

# Переключаемся на этого пользователя
USER 10014
# ---------------------------------------

EXPOSE 8080

CMD ["/usr/local/bin/xray", "-c", "/etc/xray/config.json"]
