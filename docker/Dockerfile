FROM docker.kiuber.me/base-alpine:1.0.0

RUN mkdir -p /opt/src
RUN apk update && apk add python3=3.8.2-r0 && pip3 install qrcode
RUN pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U
