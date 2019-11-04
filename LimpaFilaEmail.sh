#!/bin/bash
## script utilizadpo para apagar mensagens de um rementente ou destinatario especifico
/opt/zimbra/common/sbin/mailq | tail -n +2 | grep -v '^ *(' | awk  'BEGIN { RS = "" }
# $7=sender, $8=recipient1, $9=recipient2
{ if ($7 ="mary@dominio.com" )
    print $1 }
' | tr -d '*!' | /opt/zimbra/common/sbin/postsuper -d -
