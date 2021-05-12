#!/bin/bash
echo "You are unblocking something" 

SLEEP_INTERVAL="10"
SLEEP_INTERVAL="10"

RANDOM=$(date +%s%N | cut -b10-19)
((i = $RANDOM % SLEEP_INTERVAL))

RANDOM=$(date +%s%N | cut -b10-19)
((j = $RANDOM % SLEEP_INTERVAL))

echo -n "Enter $i + $j : "
read user_input 

ans=`expr $i + $j`

if [[ $ans == $user_input ]]
then
	RANDOM=$(date +%s%N | cut -b10-19)
	t=`echo $(( $RANDOM % SLEEP_INTERVAL + 1 ))`

	banner "Dream FB Entry!!!"
	echo "sleeping for $t"
	(sleep $t)

	sudo cp /home/rahul/uhosts /etc/hosts
else
	banner "Wrong answer"
fi
