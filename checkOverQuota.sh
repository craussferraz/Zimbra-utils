#!/bin/bash
# Verificação do uso de quotas com aviso para quotas com percentual de uso da caixa postal superior a 95%

# Declaração de variáveis
debug=1
percMinAviso=80 # percentual minimo (desativado)
percMaxAviso=95 # percentual para aviso
# Formação do cabeçalho da mensagem para envio
TMPMAIL=/tmp/quota.mail
LISTAEMAIL="< ti@triforsec.com.br >; < crauss.ferraz@triforsec.com.br >" # Informe aqui os destinatários da mensagem de aviso
echo "to: "$LISTAEMAIL >$TMPMAIL
echo "from: root@florarte.com.br " >>$TMPMAIL
echo "subject: Warning Over Quota – Correio Local Flor Arte" >>$TMPMAIL

echo >>$TMPMAIL
echo >>$TMPMAIL
echo "As quotas abaixo apresentam percentual de uso considerado elevado." >>$TMPMAIL
echo "Aos administradores do Correio Local, entrar em contato com usuarios" >>$TMPMAIL
echo "cujo a quota seja igual ou superior a 98%. Usuarios com a quota em 99%" >>$TMPMAIL
echo "ou 100%(caixa lotada) podeverao receber 10mb em carater de folego para " >>$TMPMAIL
echo "que o problema em questao seja resolvido." >> $TMPMAIL
echo >>$TMPMAIL
echo "Obs.: Uma conta com caixa postal lotada compromete o recebimento e envio de emails." >>$TMPMAIL
echo >>$TMPMAIL
echo >>$TMPMAIL
echo "-> Contas" >>$TMPMAIL
# Fim da formatação do cabeçalho da mensagem

# Gera a lista geral de usuários para usar no "loop".

/opt/zimbra/bin/zmprov -l gaa | sort | while read user # Loop com todos os usuários

do

if [ $user != comment ]
then
quotaTotal=`/opt/zimbra/bin/zmprov ga $user zimbraMailQuota | grep "Quota: " | awk '{print $2}'`
quotaAtual=`/opt/zimbra/bin/zmmailbox -z -m $user gms`
unidMed=`echo $quotaAtual | awk '{print $2}'`
quotaAtual=`echo $quotaAtual | awk '{print $1}'`
quotaAtual=`echo $quotaAtual | cut -d',' -f1`
quotaAtual=`echo $quotaAtual | cut -d'.' -f1`
# Inicio da formatação da conversão de medidas para cálculo do percentual em uso
if [ $unidMed = KB ] # Verifica se o percentual de medidas está em KB
then
let quotaAtual=$quotaAtual*1024
else
if [ $unidMed = MB ] # Verifica se o percentual de medidas está em MB
then
let quotaAtual=$quotaAtual*1024*1024
else
if [ $unidMed = GB ] # Verifica se o percentual de medidas está em GB
then
let quotaAtual=$quotaAtual*1024*1024*1024
fi
fi
fi
# Formata o valor do percentual para um numero inteiro
if [ $quotaTotal = 0 ]
then
echo > /null
else
let percUso=$quotaAtual*100/$quotaTotal
if [ $debug = 1 ]
then
if [ $unidMed = KB ]
then
let quotaT=$quotaTotal/1024
else
if [ $unidMed = MB ]
then
let quotaT=$quotaTotal/1024/1024
else
if [ $unidMed = GB ]
then
let quotaT=$quotaTotal/1024/1024/1024
fi
fi
fi
quota=`/opt/zimbra/bin/zmmailbox -z -m $user gms | awk '{print $1}' | cut -d"." -f1`
user1=`echo $user | cut -d"@" -f1`
echo -e "User: $user1\t\tUsed: $quota$unidMed ($percUso%)\tQuota: $quotaT$unidMed"
fi

if [ $percUso -gt $percMaxAviso ]
then
if [ $unidMed = KB ]
then
let quotaT=$quotaTotal/1024
else
if [ $unidMed = MB ]
then
let quotaT=$quotaTotal/1024/1024
else
if [ $unidMed = GB ]
then
let quotaT=$quotaTotal/1024/1024/1024
fi
fi
fi

quota=`/opt/zimbra/bin/zmmailbox -z -m $user gms | awk '{print $1}'`
user1=`echo $user | cut -d"@" -f1`
echo -e "Conta: $user1\t\tUsado: $quota$unidMed ($percUso%)\tQuota: $quotaT$unidMed" >>$TMPMAIL
# else
# if [ $percUso -gt $percMinAviso ]
# then
# echo "$user => %Uso Aproximado = $percUso% => ALERTA: ACIMA DO LIMITE MINIMO DE $percMinAviso" >>$TMPMAIL
# else
# echo "$user => %Uso Aproximado = $percUso%" >>$TMPMAIL
# fi
fi
fi
fi
done
/opt/zimbra/postfix/sbin/sendmail -t <$TMPMAIL
