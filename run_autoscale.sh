#!/bin/bash

OPS=$1
export OPS
TIMESTAMP=`date +"%m-%d-%Y_%H%M"`
LOGFILE=autoscale_${OPS}_${TIMESTAMP}.log
LOGDIR=/home/opc/log/autoscale_execution
TOPIC_OCID="ocid1.onstopic.oc1.iad.aaaaaaaa6yr3liaddnj7fktygwovej5ldj7tjpseav2rf7zaa4kicpophnaq"

echo "Started autoscaleall $OPS on `date +"%m-%d-%Y %H:%M"` "

case "$OPS" in
       Down)
           python3 /home/opc/OCI-AutoScale/AutoScaleALL.py -ip -a $OPS -ignoremysql -topic $TOPIC_OCID 1>$LOGDIR/$LOGFILE 2>&1
        ;;
        Up)
           python3 /home/opc/OCI-AutoScale/AutoScaleALL.py -ip -a $OPS -ignoremysql -topic $TOPIC_OCID 1>$LOGDIR/$LOGFILE 2>&1
        ;;
        All)
           python3 /home/opc/OCI-AutoScale/AutoScaleALL.py -ip -a $OPS -ignoremysql -topic $TOPIC_OCID 1>$LOGDIR/$LOGFILE 2>&1
        ;;
        *)
          echo "unknown argument: $OPS"
        ;;
esac

echo "Finished autoscaleall $OPS on `date +"%m-%d-%Y %H:%M"` "

find $LOGDIR/ -mtime +30 -name 'autoscale*.log' -exec rm {} \;

