#!/bin/bash
MEMUSAGE =$(free |grep Mem|awk '{print $3/$2 * 100.0}')
CURRENT =$(/bin/df -h / |grep --help | awk '{ print $5 }' | sed 's/%//g')
THRESHOLD =25
if [ "$CURRENT" -ge "$THRESHOLD" ]; then
mail -s 'Disk Space Alert' a.narenshanmugam@gmail.com >> EOF
Your root partition remaining free space is critically low. Used: $THRESHOLD%

EOF

fi

