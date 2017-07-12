#!/bin/bash

FILE_U="csv/passwd.csv"
FILE_P="conf/.htpasswd"

for line in `cat $FILE_U`
do
    user=`echo $line | cut -d ',' -f 1`
    pass=`echo $line | cut -d ',' -f 2`
    /usr/bin/htpasswd -b $FILE_P $user $pass
done

