#!/usr/bin/env bash

# function that handles command-not-found message.
command_not_found_handle()
{
return 127
}

# user prompt message.
prompt()
{
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
check=$(git --version)
if [[ "$check" == *"version"* ]];
then
    git_stat="-INSTALLED-"
else
    git_stat="-NOT FOUND-"
fi
check=$(betty --version)
if [[ "$check" == *"version"* ]];
then
    betty_stat="-INSTALLED-"
else
    betty_stat="-NOT FOUND-"
fi
}


# mainp program of the script (entry point).
# ------------------------------------------
clear;
prog_validator;
prompt;
sleep 1;
echo '1. Install Betty "C" code style validator ? (y/n)';
read var1
if [ "$var1" == "y" ];
then
    echo you choose option y.
fi
