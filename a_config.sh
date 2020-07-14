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
echo '*  1. gitHub ..........................[ '"$git_stat"' ]  *';
echo '*  2. github -credential helper........[ '"$git_cred"' ]  *';
echo '*  2. betty (C code style validator) ..[ '"$betty_stat"' ]  *';
echo '*  3. pep8 python codestyle ...........[ $pep_stat ]    *';
echo '*  4. INSTALL ALL                                       *';
echo '*                                                       *';
echo '*********************************************************';
echo '';
}

# installed programs checker.                                            
prog_validator()
{
check=$(git --version);
if [[ "$check" == *"version"* ]];
then
    git_stat="-INSTALLED-"
else
    git_stat="-NOT FOUND-"
fi
check=$(betty --version);
if [[ "$check" == *"version"* ]];
then
    betty_stat="-INSTALLED-"
else
    betty_stat="-NOT FOUND-"
fi
}

# Betty "C" code style install proccess.                                            
install_betty()
{
    git clone https://github.com/holbertonschool/Betty.git;
    sleep 5;
	echo '*******************************************';
    echo 'preparing for installation proccess. wait !';
	echo '*******************************************';
    sleep 2;
    sudo Betty/install.sh;
	file="betty"
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
	echo "******************";
	echo "betty installed OK";
	echo "******************";
}

# ------------------------------------------
# main program of the script (entry point).
# ------------------------------------------
prog_validator;
prompt;
sleep 1;
echo '1. Install Betty "C" code style validator ? (y/n)';
read -r var1;
if [ "$var1" == "y" ];
then
	install_betty;
fi
prompt;
