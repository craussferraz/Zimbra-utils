#! /bin/bash
## script auxiliar do zmbkp.sh para copiar arquivos para outro diretorio 
ARGS=$1
DATE=$2
CDUMPDIR=/backup/$DATE

if [ ! -d $CDUMPDIR ]; then
        mkdir -p $CDUMPDIR
fi

mv $ARGS $CDUMPDIR/
