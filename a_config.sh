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
echo 	'*********************************************************';
echo 	'*   My personal configurator v1.0 (by Ronnie B.M.)      *';
echo 	'* ===================================================== *';
echo 	'* use it by your OWN RISK, tested on UBUNTU 18 bionic   *';
echo 	'*                                                       *';
echo 	'* Github: ronniebm,  Email: ronnie.coding@gmail.com     *';
echo 	'* ----------------------------------------------------- *';
echo 	'*                                                       *';
echo 	'*  0. Automatic Installation                            *';
echo -e '*  1. betty (C code style validator) ..[ '"$BETTY_P"' ]    *';
echo -e '*  2. Zsh (Oh my Zsh shell) ...........[ '"$ZSH_P"' ]    *';
echo -e '*  3. gitff ...........................[ '"$GIT_P"' ]    *';
echo -e '*  4. git -credential helper ..........[ '"$GITCRED_P"' ]    *';
echo -e	'*  5. pep8 python codestyle ...........[ '"$PEP_P"' ]      *';
echo 	'*                                                       *';
echo 	'*********************************************************';
echo 	'';
}

# color settings
color_settings()
{
	RED="\033[0;31m"; 		# Red color.
	GREEN="\033[0;32m";		# Green color.
	CYAN="\033[0;36m"; 		# Cyan color.
	YELLOW="\033[1;33m"; 	# Yellow color.
	WHITE="\033[1;37m"; 	# White color.
	NC="\033[0m"; 			# NO Color.
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
		BETTY_STAT="INSTALLED";
		BETTY_P="${GREEN}INSTALLED${NC}";
	else
		BETTY_STAT="NOT FOUND";
		BETTY_P="${RED}NOT FOUND${NC}";
	fi
	# -------------------------------
	CHECK=$(zsh --version);
	if [[ "$CHECK" == *"ubuntu"* || "$CHECK" == *"linux"* ]];
	then
		ZSH_STAT="INSTALLED";
		ZSH_P="${GREEN}INSTALLED${NC}";
	else
		ZSH_STAT="NOT FOUND"
		ZSH_P="${RED}NOT FOUND${NC}"
	fi
	# -------------------------------
	CHECK=$(gitff --version);
	if [[ "$CHECK" == *"version"* ]];
	then
		GIT_STAT="INSTALLED"
		GIT_P="${GREEN}INSTALLED${NC}"
	else
		GIT_STAT="NOT FOUND"
		GIT_P="${RED}NOT FOUND${NC}"
	fi
	# ------------------------------
	if test -f "$FILE1";
	then
		GITCRED_STAT="INSTALLED"
		GITCRED_P="${GREEN}INSTALLED${NC}"
	else
		GITCRED_STAT="NOT FOUND"
		GITCRED_P="${RED}NOT FOUND${NC}"
	fi
}

# 1. Betty "C" code style install proccess.                                            
install_betty()
{
	echo '1. Install Betty "C" code style validator ? (y/n)';
	read -r VAR1;
	if [ "$VAR1" == "y" ];
	then
		VAR1="n";
		sudo apt-get update;
		wait;
		git clone https://github.com/holbertonschool/Betty.git;
		wait;
		echo '*******************************************';
		echo 'preparing for installation proccess. wait !';
		echo '*******************************************';
		sleep 2;
		sudo Betty/install.sh;
		rm -r Betty;
		sudo cp assets/betty /bin/;
	fi
}

# 2. Zsh Oh My ZSH shell.                                            
install_zsh()
{
	echo '2. Install Zsh (Oh my Zsh shell) ? (y/n)';
	read -r VAR1;
	if [ "$VAR1" == "y" ]; 
	then
		VAR1="n";
		sudo apt-get update;
		sudo apt-get install zsh;
		wait
		git clone https://github.com/ohmyzsh/ohmyzsh.git;
		chmod u+x $home/.oh-my-zsh/tools/install.sh;
		clear;
		echo "**************************************";
		echo "  Zsh Shell successfully Installed... ";
		echo "**************************************";
		sleep 2;
	fi
}

# -----------------------------------------
# main program of the script (entry point).
# -----------------------------------------
ENDING="n";
color_settings;
prog_validator;

while [ $ENDING == "n" ];
do
	prompt;
	if [ "$BETTY_STAT" == "NOT FOUND" ];
	then
		install_betty;

	elif [ "$ZSH_STAT" == "NOT FOUND" ];
	then
		install_zsh;

#	elif [ "$GIT_CRED" == "\033[0;31m-NOT FOUND-\033[0m" ];
#		then
#			echo "GIT CREDENTIAL HELPER NOT FOUND"

	else
		echo " Dear user, all the TOOLS are already installed.         ";
		echo "                                                         ";
		echo " **IMPORTANT: Zsh program will require your              ";
		echo " **authorization after this program END.                 ";
		echo "                                                         ";
		echo " Do you want to EXIT now ? --- (y/n)                     ";
		echo "*********************************************************";
		read -r ENDING
	fi
	prog_validator;
done
cls;
sh ohmyzsh/tools/install.sh
