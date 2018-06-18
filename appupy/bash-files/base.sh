function run_cmd() {
    local t=`date`
    echo "log info: $t: $1"
    eval $1
}

function remove_container() {
    local container_name=$1
    local cmd="docker rm -f $container_name"
    run_cmd "$cmd"
}

function _send_cmd_to_container() {
    local _container=$1
    local _cmd=$2
    local cmd="docker exec -it $_container $_cmd"
    run_cmd "$cmd"
}

