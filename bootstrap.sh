#!/bin/bash

FILE_I="csv/address.csv"

docker_run() {
    echo 'Docker Run...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        docker container run -d -p $addr:$port:3128 --name $name s035779/docker-squid
    done
}

docker_start() {
    echo 'Docker Start...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker container start $name
    done
}

docker_stop() {
    echo 'Docker Stop...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker container stop $name
    done
}

docker_rm() {
    echo 'Docker Remove...'
    docker container prune
    echo ''
    docker image prune
    echo ''
    docker system prune
    echo ''
    echo 'Docker image list...'
    docker image ls
}

docker_logs() {
    echo 'Docker Logs...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        docker container logs $name
    done
}

docker_inspect() {
    echo 'Docker Inspect...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        docker container inspect $name | jq ".[0].NetworkSettings.IPAddress"
    done
}

docker_test() {
    echo 'Docker Testing...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        echo "<<< [ $name ] proxy --> $addr:$port <<<"
        curl -U test1:test1 -x $addr:$port --silent --head https://www.google.com | head -2
    done
}

docker_status() {
    echo 'Docker container list...'
    docker container ls -a
    echo ''
    echo 'Docker systen usage...'
    docker system df
}

docker_csv() {
    rm $FILE_I
    ip addr show | sed  -n -E 's/^[ \t]*inet[ \t]*(10.0.0.[0-9]+)\/.*$/\1/p' | while read line
    do
        addr=`echo $line`
        port=`echo 54321`
        name=`echo squid${RANDOM}`
        echo ">>> [ $name ] proxy --> $addr:$port >>>"
        echo "${addr},${port},${name}" >> $FILE_I
    done
}

docker_build() {
    echo 'Docker image build...'
    docker image build -t s035779/docker-squid .
    echo ''
    echo 'Docker image list...'
    docker image ls
}

if [ $1 = run ]; then
    docker_run
elif [ $1 = start ]; then
    docker_start
elif [ $1 = stop ]; then
    docker_stop
elif [ $1 = rm ]; then
    docker_rm
elif [ $1 = logs ]; then
    docker_logs
elif [ $1 = inspect ]; then
    docker_inspect
elif [ $1 = test ]; then
    docker_test
elif [ $1 = status ]; then
    docker_status
elif [ $1 = csv ]; then
    docker_csv
elif [ $1 = build ]; then
    docker_build
fi

