#!/bin/bash

## Esconde contas fechadas do GAL
## Deve ser executado como user zimbra

if [ ${LOGNAME} != "zimbra" ]; then
	echo "Esse progama deve ser executado pelo usuario zimbra!"
fi

for conta in `zmprov sa "zimbraAccountStatus=closed"` 
do
	echo "## Removendo a conta fechada $conta da pesquisa do GAL ##"
	zmprov ma $conta zimbraHideInGal TRUE
done

