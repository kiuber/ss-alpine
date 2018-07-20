import json
import base64
import os
import sys

# https://shadowsocks.org/en/config/quick-guide.html
# ss://method:password@hostname:port

config_path = '/etc/shadowsocks.json'
with open(config_path, "r") as read_file:
    data = json.load(read_file)

    method = data['method']
    hostname = sys.argv[1]
    port = sys.argv[2]

    for docker_port, passowrd in data['port_password'].items() :

        plain = '{}:{}@{}:{}'.format(method, passowrd, hostname, port)
        base64_plain = base64.b64encode(plain)
        qrcode_plain = 'ss://{}#{}'.format(base64_plain, hostname)
        print(qrcode_plain)
        cmd = 'qr ' + qrcode_plain
        os.system(cmd)

