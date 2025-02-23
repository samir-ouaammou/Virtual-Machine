#!/bin/bash

MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
MEM_USED=$(free -m | awk 'NR==2{print $3}')
MEM_PERCENT=$(echo "scale=2; $MEM_USED/$MEM_TOTAL*100" | bc)
DISK_TOTAL=$(df -h --total | grep 'total' | awk '{print $2}')
DISK_USED=$(df -m --total | grep 'total' | awk '{print $3}')
DISK_PERCENT=$(df -h --total | grep 'total' | awk '{print $5}')
CPU_LOAD=$(mpstat 1 1 | grep "Average" | awk '{printf "%.1f%%\n", 100 - $NF}')
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip addr | awk '/ether/ {print $2}')
SUDO_CMDS=$(grep -c 'COMMAND' /var/log/sudo/sudo.log)
LVM_USE=$(lsblk | grep -q 'lvm' && echo yes || echo no)

wall "	#Architecture: $(uname -a)
	#CPU physical : $(nproc --all)
	#vCPU: $(nproc)
	#Memory Usage: $MEM_USED/$MEM_TOTAL"MB" ($MEM_PERCENT%)
	#Disk Usage: $DISK_USED/$DISK_TOTAL"b" ($DISK_PERCENT)
	#CPU Load: $CPU_LOAD
	#Last boot: $(who -b | awk '{print $3, $4}')
	#LVM use: $LVM_USE
	#Connections TCP : $(ss -t | grep ESTAB | wc -l) ESTABLISHED
	#User log: $(who | wc -l)
	#Network: IP $IP_ADDR ($MAC_ADDR)
	#Sudo : $SUDO_CMDS cmd"


