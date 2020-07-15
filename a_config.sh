#!/usr/bin/env bash

# function that handles command-not-found message.
command_not_found_handle()
{
return 127;
}

# user prompt message.
prompt()
{
clear;
echo '*********************************************************';
echo '*   My personal configurator v1.0 (by Ronnie B.M.)      *';
echo '* ===================================================== *';
echo '* use it by your OWN RISK, tested on UBUNTU 18 bionic   *';
echo '*                                                       *';
echo '* Github: ronniebm,  Email: ronnie.coding@gmail.com     *';
echo '* ----------------------------------------------------- *';
echo '*                                                       *';
echo '*  0. Automatic Installation                            *';
echo '*  1. betty (C code style validator) ..[ '"$BETTY_STAT"' ]  *';
echo '*  2. gitHub ..........................[ '"$GIT_STAT"' ]  *';
echo '*  3. github -credential helper........[ '"$GIT_CRED"' ]  *';
echo '*  4. pep8 python codestyle ...........[ '"$PEP_STAT"' ]    *';
echo '*                                                       *';
echo '*********************************************************';
echo '';
}


# installed programs checker.                                            
prog_validator()
{
FILE1=/$HOME/.git-credentials
COUNTER=0;

# -------------------------------
CHECK=$(betty --version);
if [[ "$CHECK" == *"version"* ]];
then
    BETTY_STAT="-INSTALLED-"
else
    BETTY_STAT="-NOT FOUND-"
fi
# -------------------------------
CHECK=$(git --version);
if [[ "$CHECK" == *"version"* ]];
then
    GIT_STAT="-INSTALLED-"
else
    GIT_STAT="-NOT FOUND-"
fi
# ------------------------------
if test -f "$FILE1";
then
    GIT_CRED="-INSTALLED-"
else
    GIT_CRED="-NOT FOUND-"
fi
}


# 1. Betty "C" code style install proccess.                                            
install_betty()
{
	if [ "$BETTY_STAT" == "-NOT FOUND-" ];
	then
		echo '1. Install Betty "C" code style validator ? (y/n)';
		read -r VAR1;
		if [ "$VAR1" == "y" ];
		then
			sudo apt-get update;
			wait;
			git clone https://github.com/holbertonschool/Betty.git;
			wait;
			echo '*******************************************';
			echo 'preparing for installation proccess. wait !';
			echo '*******************************************';
			sleep 2;
			sudo Betty/install.sh;
			file="betty";
			echo "#!/bin/bash" > $file;
			echo "# Simply a wrapper script to keep you from having to use betty-style" >> $file;
			echo "# and betty-doc separately on every item." >> $file;
			echo "# Originally by Tim Britton (@wintermanc3r), multiargument added by" >> $file;
			echo "# Larry Madeo (@hillmonkey)" >> $file;
			echo "" >> $file;
			echo "BIN_PATH=\"/usr/local/bin\"" >> $file;
			echo "BETTY_STYLE=\"betty-style\"" >> $file;
			echo "BETTY_DOC=\"betty-doc\"" >> $file;
			echo "" >> $file;
			echo "if [ \"\$#\" = \"0\" ]; then" >> $file;
			echo "    echo \"No arguments passed.\"" >> $file;
			echo "    exit 1" >> $file;
			echo "fi" >> $file;
			echo "" >> $file;
			echo "for argument in \"\$@\" ; do" >> $file;
			echo "    echo -e \"\n========== \$argument ==========\"" >> $file;
			echo "    \${BIN_PATH}/\${BETTY_STYLE} \"\$argument\"" >> $file;
			echo "    \${BIN_PATH}/\${BETTY_DOC} \"\$argument\"" >> $file;
			echo "done" >> $file;
			chmod a+x $file;
			rm -r Betty;
			sudo mv $file /bin/;
		fi
	fi
}

# ------------------------------------------
# main program of the script (entry point).
# ------------------------------------------
ENDING="n";

prog_validator;
while [ $ENDING == "n" ];
do
	prompt;
	if [ "$BETTY_STAT" == "-NOT FOUND-" ];
	then
		install_betty;

#	elif [ "$GIT_STAT" == "-NOT FOUND-" ];
#	then
#		echo "GIT HUB NOT FOUND"

#	elif [ "$GIT_CRED" == "-NOT FOUND-" ];
#		then
#			echo "GIT CREDENTIAL HELPER NOT FOUND"
	
	else
		echo " Dear user, all the TOOLS are already installed.";
		echo "                                                ";
		echo " Do you want to EXIT ? (y/n)                    ";
		read -r ENDING
	fi
prog_validator;
done
echo '                                                         ';
echo '*********************************************************';
echo '*                  PROGRAM FINISHED !                   *';
echo '*********************************************************';