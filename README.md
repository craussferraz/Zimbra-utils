# Zimbra: Scripts uteis!

Olá, nesse repositório vocês poderão encontra diversos scripts para execução em modo texto para **servidores de e-mail Zimbra** que colecionei ou criei ao passar dos anos utilizando o Zimbra. 


## Desvendando os Scripts:
Abaixo vai uma breve explicação do funcionamento de cada  script:

### [checkleakedmail.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/checkleakedmail.sh)

Este script tem a finalidade de procurar por possiveis violações em uma conta.

### [checkOverQuota.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/checkOverQuota.sh)

Verificação do uso de quotas com aviso para quotas com percentual de uso da caixa postal superior a 95%.
### [checkQuotaZimbra.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/checkquotaZimbra.sh) 

Cria uma lista de todas as contas e suas respectivas cotas.

### [copiabkp.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/copiabkp.sh)

Script auxiliar do zmbkp.sh para copiar arquivos para outro diretorio.

### [criaUsusarioZimbraQuota.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/criaUsuarioZimbraCota.sh)

Cria aparti de um arquivo .cvs usuários, email e cota(em Bytes ex.: para 100MB use: 104857600).

### [LimpaEmailsAntigosZimbra.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/LimpaEmailsAntigosZimbra.sh)

Script apaga as mensagens anteriores a uma data de uma ou mais contas.

### [LimpaFilaEmail.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/LimpaFilaEmail.sh) 

Script para excluir e-mails de um remetente ou um destinatario da fila de e-mails.

### [removeFechadasGAL.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/removeFechadasGAL.sh)

Esconde contas fechadas do GAL.

### [zmbkp.sh](https://github.com/craussferraz/Zimbra-utils/blob/master/zmbkp.sh)

Esse script foi desenvolvido para fazer backup de uma ou mais contas simultaneamente com o objetivo de diminuir o tempo total do processo de backup.


## Template Zabbix de monitoramento de filas de e-mails:

![alt_text](https://github.com/craussferraz/Zimbra-utils/blob/master/zabbix-3.4-zimbra/graph.png)
Criei esse template para me auxiliar a monitorar situaçoes na minha fila de e-mails no meu Zimbra de forma a identificar problemas como contas em over quota, problemas retenção de mensagens e envio indevido de spam em tempo hábil.

### Como fazer

	1 - Copie o arquivo zabbix-queue-monitor /etc/sudoers.d/
	    1.1 - Altere a permissão do arquivo para 0440
	2 - Copie o arquivo userparameter_queue-monitor.conf para /etc/zabbix/zabbix_agentd.d
	3 - Reinicie o zabbix-agent
	4 - No seu servidor Zabbix, importe o arquivo Template Zimbra queue monitor.xml
	5- Adicione o template aos seus hosts Zimbra.

Aproveitem!
