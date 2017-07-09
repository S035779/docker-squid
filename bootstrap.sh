#!/bin/bash

dir=~/

docker_run() {
echo 'Docker Run...'
cd $dir
if [ ! -d "conf" ]; then
tar xvf conf.tar
fi
docker run --privileged -d -p 54321:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log01/:/var/log/squid/ -v /home/squid/cache01/:/var/spool/squid/ --name squid01 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54322:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log02/:/var/log/squid/ -v /home/squid/cache02/:/var/spool/squid/ --name squid02 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54323:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log03/:/var/log/squid/ -v /home/squid/cache03/:/var/spool/squid/ --name squid03 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54324:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log04/:/var/log/squid/ -v /home/squid/cache04/:/var/spool/squid/ --name squid04 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54325:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log05/:/var/log/squid/ -v /home/squid/cache05/:/var/spool/squid/ --name squid05 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54326:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log06/:/var/log/squid/ -v /home/squid/cache06/:/var/spool/squid/ --name squid06 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54327:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log07/:/var/log/squid/ -v /home/squid/cache07/:/var/spool/squid/ --name squid07 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54328:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log08/:/var/log/squid/ -v /home/squid/cache08/:/var/spool/squid/ --name squid08 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54329:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log09/:/var/log/squid/ -v /home/squid/cache09/:/var/spool/squid/ --name squid09 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54330:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log10/:/var/log/squid/ -v /home/squid/cache10/:/var/spool/squid/ --name squid10 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54331:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log11/:/var/log/squid/ -v /home/squid/cache11/:/var/spool/squid/ --name squid11 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54332:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log12/:/var/log/squid/ -v /home/squid/cache12/:/var/spool/squid/ --name squid12 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54333:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log13/:/var/log/squid/ -v /home/squid/cache13/:/var/spool/squid/ --name squid13 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54334:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log14/:/var/log/squid/ -v /home/squid/cache14/:/var/spool/squid/ --name squid14 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54335:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log15/:/var/log/squid/ -v /home/squid/cache15/:/var/spool/squid/ --name squid15 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54336:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log16/:/var/log/squid/ -v /home/squid/cache16/:/var/spool/squid/ --name squid16 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54337:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log17/:/var/log/squid/ -v /home/squid/cache17/:/var/spool/squid/ --name squid17 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54338:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log18/:/var/log/squid/ -v /home/squid/cache18/:/var/spool/squid/ --name squid18 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54339:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log19/:/var/log/squid/ -v /home/squid/cache19/:/var/spool/squid/ --name squid19 s035779/squid:1.2 /sbin/init
docker run --privileged -d -p 54340:3128 -v /home/squid/conf/:/etc/squid/ -v /home/squid/log20/:/var/log/squid/ -v /home/squid/cache20/:/var/spool/squid/ --name squid20 s035779/squid:1.2 /sbin/init
}

docker_start() {
echo 'Docker Start...'
cd $dir
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
docker start squid$i
done
}

docker_stop() {
echo 'Docker Stop...'
cd $dir
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
docker stop squid$i
done
}

docker_rm() {
echo 'Docker Remove...'
cd $dir
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
docker rm squid$i
done
}

docker_logs() {
echo 'Docker Logs...'
cd $dir
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
docker logs squid$i
done
}

docker_inspect() {
echo 'Docker Inspect...'
cd $dir
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
echo "--- squid$i ---"
docker inspect squid$i | jq ".[0].NetworkSettings.IPAddress"
done
}

docker_test() {
echo 'Docker Testing...'
cd $dir
for i in 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
do
echo "--- proxy port:543$i ---"
curl -U test1:test1 -x localhost:543$i --silent --head https://www.google.com | head -2
done
}

if [ $1 = run ]; then
    docker_run
    docker ps
elif [ $1 = start ]; then
    docker_start
    docker ps
elif [ $1 = stop ]; then
    docker_stop
    docker ps -a
elif [ $1 = rm ]; then
    docker_rm
    docker ps -a
elif [ $1 = logs ]; then
    docker_logs
    docker ps
elif [ $1 = inspect ]; then
    docker_inspect
    docker ps
elif [ $1 = test ]; then
    docker_test
    docker ps
fi

