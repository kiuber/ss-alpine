FROM docker.kiuber.me/base-alpine:1.0.0

RUN mkdir -p /opt/src && cd /opt/src/
RUN apk update &&\
    apk add python3 python3-dev py-pip &&\
    pip install shadowsocks qrcode
    
