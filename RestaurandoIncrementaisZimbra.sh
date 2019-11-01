#! /bin/bash
## Script construido para recuperar backups a parti de arquivos incrementais

## Data do Ultimo arquivo a ser recuperado no formato: YYYYMMDD
TIMEFIM=20190228
## Data do primeiro aruivo a ser recuperado no formato: YYYYMMDD
TIMEINI=20190101
## Local do Backup
BKPDIR=/backup/
## Onde desenpacotar
BKPTEMP=$BKPDIR/bkptemp/
## Conta a ser restaurada
ZACOUNT="COLOQUE SUA CONTA AQUI" 

## Registro de quais arquivos serão importados
BKPLOG=/opt/zimbra/log/RecuperaIncremental.log

## Procurando por arquivos a serem restaurados
echo > $BKPLOG/$ZACOUNT.log
find $BKPDIR -iname $ZACOUNT.tgz -type f -newermt $TIMEINI -not -newermt $TIMEFIM > $BKPLOG/$ZACOUNT.log

## Restaurando eles
cat $BKPLOG/$ZACOUNT.log| while read line 
do 
	# Restaurando...
	zmmailbox -z -m $ZACOUNT postRestURL "//?fmt=tgz&resolve=skip" $BKPTEMP/$ZACOUNT.tgz

	#removendo arquivos já restaurados
	rm -rf $BKPTEMP/$ZACOUNT.tgz
done
