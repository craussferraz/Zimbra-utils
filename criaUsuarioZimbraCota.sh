#! /bin/bash
cat /tmp/arquivo| while read LINE; do
  EMAIL=`echo $LINE | cut -d, -f1`
  NOME=`echo $LINE | cut -d, -f2`
  COTA=`echo $LINE | cut -d, -f3`
  
  zmprov ca $EMAIL 'Tlt@#2019' displayName "$NOME" zimbraMailQuota $COTA

done
