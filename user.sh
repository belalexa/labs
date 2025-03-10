#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_USEREXISTS=70

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)

# sudo chmod -R 777 /var/www/test/public_html to provide the acccess.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

#test, if both argument are there
if [ $# -eq 2 ]; then
username=$1
pass=$2

	# Check if user already exists.
	grep -q "$username" /etc/passwd
	if [ $? -eq $SUCCESS ] 
	then	
	echo "User $username does already exist."
  	echo "please chose another username."
	exit $E_USEREXISTS
	fi  


	useradd -p `mkpasswd "$pass"` -d /home/"$username" -m -g users -s /bin/bash "$username"

	echo "the account is setup"

else
        echo  " this programm needs 2 arguments you have given $# "
        echo  " you have to call the script $0 username and the pass "
fi

exit 0
