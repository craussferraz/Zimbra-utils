#!/bin/bash
# checks log file and gets a count of authentications sent per minute, per user
# and if the count exceeds the maxmails value the user's account is locked.

logfile="/var/log/zimbra.log"
maxmails="5"
mydomain="domain.tld"
support="support@$mydomain"
accounts="/tmp/active_accounts"

su - zimbra -c "/opt/zimbra/bin/zmaccts" | grep "@" | grep active | awk '{print $1}' > $accounts

zgrep -i "sasl_method=LOGIN, sasl_username" $logfile | sed 's/  / /g' | awk -F"[ :]" '{print $3":"$4,$13;}' | sed 's/sasl_username=//g' | sort | uniq -c | sort -n| \
while read line
do
count=`echo ${line} | cut -d' ' -f 1`
userid=`echo ${line} | cut -d' ' -f 3`
timestamp=`echo ${line} | cut -d' ' -f 2`
active=`grep "$userid@$mydomain" $accounts`

if [ "$count" -gt "$maxmails" ] && [ "$active" == "$userid@$mydomain" ]; then
echo "Maximum email rate exceeded, $userid@$mydomain will be locked"
#su - zimbra -c "/opt/zimbra/bin/zmprov ma $userid@$mydomain zimbraAccountStatus locked"
subject="$userid account locked due to excessive connections"
# Email text/message
message="/tmp/emailmessage.txt"
echo "$userid account has been locked as there were $count connections made at"> $message
echo "$timestamp. Please have the user change their password, and check for phishing" >>$message
echo "emails if possible." >>$message 

# send an email using /bin/mail
#/bin/mail -s "$subject" "$support" < $message
#rm -f $message

#update list of active accounts
su - zimbra -c "/opt/zimbra/bin/zmaccts" | grep "@" | grep active | awk '{print $1}' > $accounts
fi
 done
rm -f $accounts
#postfix restart


