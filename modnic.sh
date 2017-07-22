#!/bin/bash
dev=`echo $2`
net='10.0.0'
net_add() {
  for i in {2..20}
  do
    echo "IP address ${net}.${i} has been added to device ${dev}."
    nmcli connection modify ${dev} +ipv4.addresses ${net}.${i}/24
  done
  nmcli device disconnect ${dev}; nmcli device connect ${dev}
}
net_del() {
  for i in {2..20}
  do
    echo "IP address ${net}.${i} has been deleted from device ${dev}."
    nmcli connection modify ${dev} -ipv4.addresses ${net}.${i}/24
  done
  nmcli device disconnect ${dev}; nmcli device connect ${dev}
}

if [ $1 = add ]; then
  net_add
  ip addr show ${dev}
elif [ $1 = del ]; then
  net_del
  ip addr show ${dev}
fi
