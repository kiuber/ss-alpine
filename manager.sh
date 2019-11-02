domain='docker.kiuber.me'

ss_image_name='ss-alpine'
ss_image_version=1.0.0
ss_image="$domain/$ss_image_name:$ss_image_version"

ss_container='ss'

ss_config_in_host="$PWD/config/shadowsocks.json"
ss_config_in_container='/etc/shadowsocks.json'

py_files_in_host="$PWD/appupy/py-files"
py_files_in_container='/opt'

source "$PWD/appupy/base-bash/_base.sh"
source "$PWD/appupy/base-bash/_docker.sh"

function build_ss() {
    local cmd="docker build -t $ss_image $PWD/docker"
    _run_cmd "$cmd"
}

function build_images() {
    build_ss
}

function run() {
    local cmd="docker run --name $ss_container"
    cmd="$cmd -v $ss_config_in_host:$ss_config_in_container"
    cmd="$cmd -v $py_files_in_host:$py_files_in_container"
    cmd="$cmd -p 8127:80"
    cmd="$cmd -d --privileged=true $ss_image ssserver -c $ss_config_in_container"
    _run_cmd "$cmd"
}

function stop() {
    _remove_container $ss_container
}

function start() {
    run
}

function restart() {
    _remove_container $ss_container
    run
}

function show_qrcode() {
    local hostname=$2
    local port=$3
    local cmd='python /opt/qrcode.py $hostname $port'
    _send_cmd_to_container $ss_container "$cmd"
}

function to_ss() {
    _send_cmd_to_container $ss_container 'sh'
}

function logs() {
    local cmd="docker logs -f $ss_container"
    _run_cmd "$cmd"
}

function help() {
    cat <<-EOF

        Valid options are:
            build_images

            run
            stop
            start 
            restart

            show_qrcode (\$hostname, \$port)
            to_ss

            logs

            help                      show this help message and exit

EOF
}

action=${1:-help}
$action "$@"

