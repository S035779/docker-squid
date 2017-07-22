#!/bin/bash

FILE_I="csv/address.csv"

docker_run() {
    echo '>>> Docker Run...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        docker network create $name
        docker container run -d -p $addr:$port:3128 --net=$name --name $name s035779/docker-squid
    done
    echo ''
}

docker_start() {
    echo '>>> Docker Start...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker container start $name
    done
    echo ''
}

docker_stop() {
    echo '>>> Docker Stop...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker container stop $name
    done
    echo ''
}

docker_rm() {
    echo '>>> Docker container remove...'
    docker container prune
    echo ''
    echo '>>> Docker image remove...'
    docker rmi $(docker images -q)
    echo ''
    echo '>>> Docker resource remove...'
    docker system prune
    echo ''
}

docker_logs() {
    echo '>>> Docker Logs...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        docker container logs $name
    done
    echo ''
}

docker_inspect() {
    echo '>>> Docker Inspect...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        docker container inspect $name | jq ".[0].NetworkSettings.IPAddress"
    done
    echo ''
}

docker_test() {
    echo '>>> Docker Testing...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        curl -U test1:test1_password -x $addr:$port --silent --head https://www.google.com | head -2
    done
    echo ''
}

docker_status() {
    echo '>>> Docker container list...'
    docker container ls -a
    echo ''
    echo '>>> Docker network list...'
    docker network ls
    echo ''
    echo '>>> Docker image list...'
    docker image ls
    echo ''
    echo '>>> Docker systen usage...'
    docker system df
    echo ''
}

docker_csv-ip() {
    rm $FILE_I
    echo '>>> Docker ip list...'
    ip addr show | sed  -n -E 's/^[ \t]*inet[ \t]*(10.0.[0-9]+.[0-9]+)\/.*$/\1/p' | while read line
    do
        addr=`echo $line`
        port=`echo 54321`
        name=`echo squid${RANDOM}`
        echo ">>> [ $name ] proxy --> $addr:$port >>>"
        echo "${addr},${port},${name}" >> $FILE_I
    done
    echo ''
}

docker_csv-port() {
    rm $FILE_I
    echo '>>> Docker ip list...'
    ip addr show | sed  -n -E 's/^[ \t]*inet[ \t]*(10.0.[0-9]+.[0-9]+)\/.*$/\1/p' | while read line
    do
        for i in {54321..54340}
        do
            addr=`echo $line`
            port=`echo $i`
            name=`echo squid${RANDOM}`
            echo ">>> [ $name ] proxy --> $addr:$port >>>"
            echo "${addr},${port},${name}" >> $FILE_I
        done
    done
    echo ''
}

docker_build() {
    echo '>>> Docker image build...'
    docker image build -t s035779/docker-squid .
    echo ''
}

if [ $1 = run ]; then
    docker_csv-ip
    docker_build
    docker_run
elif [ $1 = run2 ]; then
    docker_csv-port
    docker_build
    docker_run
elif [ $1 = start ]; then
    docker_start
elif [ $1 = stop ]; then
    docker_stop
elif [ $1 = status ]; then
    docker_status
elif [ $1 = test ]; then
    docker_test
elif [ $1 = logs ]; then
    docker_logs
elif [ $1 = inspect ]; then
    docker_inspect
elif [ $1 = remove ]; then
    docker_rm
fi

