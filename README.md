# Zimbra: Scripts uteis!

Olá, nesse repositório vocês poderão encontra diversos scripts para execução em modo texto para **servidores de e-mail Zimbra** que colecionei ou criei ao passar dos anos utilizando o Zimbra. 


## Desvendando os Scripts
Abaixo vai uma breve explicação do funcionamento de cada  script:

### checkleakedmail.sh

Este script tem a finalidade de procurar por possiveis violações em uma conta.

### checkOverQuota.sh

Verificação do uso de quotas com aviso para quotas com percentual de uso da caixa postal superior a 95%.
### checkQuotaZimbra.sh 

Cria uma lista de todas as contas e suas respectivas cotas.

### copiabkp.sh

Script auxiliar do zmbkp.sh para copiar arquivos para outro diretorio.

### criaUsusarioQuota.sh 

Cria aparti de um arquivo .cvs usuários, email e cota(em Bytes ex.: para 100MB use: 104857600).

### [LimpaEmailsAntigosZimbra.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/LimpaEmailsAntigosZimbra.sh)

Script apaga as mensagens anteriores a uma data de uma ou mais contas.

### LimpaFilaEmail.sh 

Script para excluir e-mails de um remetente ou um destinatario da fila de e-mails.

### removeFechadasGAL.sh

Esconde contas fechadas do GAL.

### zmbkp.sh

Esse script foi desenvolvido para fazer backup de uma ou mais contas simultaneamente com o objetivo de diminuir o tempo total do processo de backup.
