#! /bin/bash
## Esse script foi desenvolvido para fazer backup de mais de uma conta simultaneamente com o objetivo de diminuir o tempo total do processo de backup.
## Ele é ajustavel as capacidades de cada servidor Zimbra podendo fazer backup de 1 ou mais contas simultaneamente.
## A exucucao deste script sem argumentos, vai gerar um backup incremental. Para executar um backup completo use por exemplo ./zmbkp.sh full
 
declare -a pids
declare -g -a mbox
THREADS=3 ## numero de processos simultâneos
PROG_ARGS=$#
##  Local onde o log do script
LOG=/tmp/bkp.log
ZHOME=/opt/zimbra
ZBACKUP=/opt/zimbra/backup
ZCONFD=$ZHOME/conf
DATE=`date +"%d%m%y"`
ZDUMPDIR=$ZBACKUP/$DATE
ZMBOX=/opt/zimbra/bin/zmmailbox
## script auxiliar para copiar o arquivo de backup para um diretorio onde esta montado uma partição em outro servidor.
#CPBKP=/usr/bin/copiabkp.sh ## script que copia os tgz para /backup


echo -e "         ##############################
          ##   START BACKUP $DATE    ##
          ##############################" >> $LOG

¨ >> $LOG

mbox=( `/opt/zimbra/bin/zmprov -l gaa | grep -vi -E "galsync|virus|admin|ham|spam"|sort` )

#echo ${mbox[@]}
if [ $PROG_ARGS -eq 0 ]; then
    DT=`date --date='1 days ago' +"%m/%d/%Y"`
    query="&query=after:$DT"
fi

if [ ! -d $ZDUMPDIR ]; then
        mkdir -p $ZDUMPDIR
fi

cd $ZDUMPDIR

start=$(date '+%s')
for conta in "${mbox[@]}"; do

                while [ "${#pids[@]}" -eq $THREADS ]; do # enquanto o numero de pids for igual a THREADS faça...
                        sleep 30 # espere 30 segundos 
                        for pid in "${!pids[@]}"; do # Para pid no indice de pids faça...

                                if ! ps "$pid" >/dev/null; then # Se o pid não existir...
                                                ## Para uso opcional
                                                #$CPBKP ${pids[$pid]}.tgz $DATE & # Chame o script para copiar para o /backup
                                                echo "conta ${pids[$pid]} ...done" >> $LOG
                                                unset pids[$pid] # apague o pid conrespondente no array
                                                break # saia do laço
                                fi
                        done

                 done
                        echo $conta
                        $ZMBOX -z -m $conta getRestURL "//?fmt=tgz$query" > $conta.tgz 2>> $LOG &
                        pid=$! # Recebe o pid do processo
                        pids[$pid]=$conta # Adiciona ao array pids o processo com o valor conta



done
# tempo de execução do script em segundos (para poder medir o desempenho alterando o numero de simultanoes de contas)

echo "Tempo de execução: $((`date '+%s'` - $start))" >> $LOG

