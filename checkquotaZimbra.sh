#! /bin/bash
# Qua 26 Mar 2014 14:44:43 BRT 
echo > /tmp/sizequota.txt
WHO=`whoami`
	if [ $WHO = "zimbra" ]
	then
	all_account=`zmprov -l gaa $1`;
		for account in ${all_account}
		do
			mb_size=`zmmailbox -z -m ${account} gms`;
			echo "Mailbox size of ${account} = ${mb_size}" >> /tmp/sizequota.txt;
		done
	else
echo "Execute this script as user zimbra (su - zimbra)"
fi
