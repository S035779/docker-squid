#!/bin/bash

FILE_U="csv/passwd.csv"
FILE_P="conf/.htpasswd"

if [ -f ${FILE_P} ] ; then
    rm $FILE_P
fi
/usr/bin/htpasswd -c -b $FILE_P test1 test1_password
for line in `cat $FILE_U`
do
    user=`echo $line | cut -d ',' -f 1`
    pass=`echo $line | cut -d ',' -f 2`
    /usr/bin/htpasswd -b $FILE_P $user $pass
done

