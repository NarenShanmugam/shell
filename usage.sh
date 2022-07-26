#!/bin/bash
echo `date`
TO="a.narenshanmugam@gmail.com"
#cpu use threshold
cpu_threshold='330'
 #mem idle threshold
mem_threshold='400'
 #disk use threshold
disk_threshold='250'
#---cpu
cpu_usage () {
cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d "."`
cpu_use=`expr 100 - $cpu_idle`
 echo "cpu utilization: $cpu_use"
if [ $cpu_use -lt $cpu_threshold ]
then
        echo "cpu warning!!!"|sendmail $TO
    else
        echo "cpu ok!!!"|sendmail $TO
fi
}
#---mem
mem_usage () {
 #MB units
mem_free=`free -m | grep "Mem" | awk '{print $4+$6}'`
 echo "memory space remaining : $mem_free MB"
if [ $mem_free -lt $mem_threshold  ]
    then
        echo "mem warning!!!"|sendmail $TO
    else
        echo "mem ok!!!"|sendmail $TO
fi
}
#---disk
disk_usage () {
disk_use=`df -P | grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -f 1 -d "%"`
 echo "disk usage : $disk_use" 
if [ $disk_use -lt $disk_threshold ]
    then
        echo "disk warning!!!"|sendmail $TO
    else
        echo "disk ok!!!"|sendmail $TO
fi
 
 
}
cpu_usage
mem_usage
disk_usage
