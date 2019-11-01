#!/bin/bash

# Script apaga as mensagens anteriores a uma data de uma ou mais contas.
# INSTALE O SCRIPT EM UM LOCAL ONDE O ZIMBRA TENTE PREMISSOES DE LEITURA E ESCRITA.


CONTAS=" COLOQUE SUAS CONTAS AQUI "

for CONTAMAIL in ${CONTAS}; do
    # Remove espaços vazios
    crunch_remove() {
            while read FOO ; do
            echo $FOO
            done
                     }

    while true 
        do

            # Gera lista de mensagens antigas (data em formato US)             == ALTERE A SUA DATA ABAIXO ==
            /opt/zimbra/bin/zmmailbox -z -m ${CONTAMAIL} s -l 1000 -t message "in:/Inbox (before:01/01/18)" > lista-${CONTAMAIL}.tmp
    
            # Remove espaços vazios e gera lista de IDs das msgs
            cat lista-${CONTAMAIL}.tmp|crunch_remove|cut -d" " -f2|sed s/'1000,'//g|sed s,Type,,g|sed s,'----',,g|sed '/^[\ ]\+\?$/d'|sed s/'\,'//g > lista-${CONTAMAIL}.txt
    
            # Verifica se a lista esta vazia e sai do loop se estiver
            if [ `cat lista-${CONTAMAIL}.txt|wc -l` == 1 ]; then
                break;
            fi
    
            # Remove mensagens geradas na lista anterior
            while read ID_CLEAN;do
            /opt/zimbra/bin/zmmailbox -z -m ${CONTAMAIL} dm $ID_CLEAN
            done < /tmp/lista-id.txt
        done
rm -rf lista-${CONTAMAIL}.tmp
rm -rf lista-${CONTAMAIL}.txt

done
