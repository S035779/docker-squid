#!/bin/bash

FILE_I="csv/address.csv"

docker_run() {
    echo 'Docker Run...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        name=`echo $line | cut -d ',' -f 3`
        docker run -d -p $addr:$port:3128 --name $name s035779/docker-squid
    done
}

docker_start() {
    echo 'Docker Start...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker start $name
    done
}

docker_stop() {
    echo 'Docker Stop...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker stop $name
    done
}

docker_rm() {
    echo 'Docker Remove...'
    docker system prune
}

docker_logs() {
    echo 'Docker Logs...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        docker logs $name
    done
}

docker_inspect() {
    echo 'Docker Inspect...'
    for line in `cat $FILE_I`
    do
        name=`echo $line | cut -d ',' -f 3`
        echo "--- squid$i ---"
        docker inspect $name | jq ".[0].NetworkSettings.IPAddress"
    done
}

docker_test() {
    echo 'Docker Testing...'
    for line in `cat $FILE_I`
    do
        addr=`echo $line | cut -d ',' -f 1`
        port=`echo $line | cut -d ',' -f 2`
        echo "--- proxy port:$port ---"
        curl -U test1:test1 -x $addr:$port --silent --head https://www.google.com | head -2
    done
}

docker_status() {
    echo 'Docker status...'
    docker ps
    docker system df
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
fi

