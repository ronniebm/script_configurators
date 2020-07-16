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
echo -e '*  3. git .............................[ '"$GIT_P"' ]    *';
echo -e '*  4. git -credential helper ..........[ '"$GITCRED_P"' ]    *';
echo -e	'*  5. shellcheck validator ............[ '"$SHELLCHECK_P"' ]    *';
echo -e	'*  6. valgrind memory tester ..........[ '"$VALGRIND_P"' ]    *';
echo -e	'*  7. MYSQL database ..................[ '"$MYSQL_P"' ]    *';
echo 	'*                                                       *';
echo 	'*********************************************************';
echo 	'';
}

# color settings
color_settings()
{
	RED="\033[0;31m"; GREEN="\033[0;32m"; CYAN="\033[0;36m";
	YELLOW="\033[1;33m"; WHITE="\033[1;37m"; NC="\033[0m";
}

skip_flags()
{
	SKIP_BETTY=0; SKIP_ZSH=0; SKIP_GIT=0; SKIP_GITCRED=0;
	SKIP_SHELLCHECK=0; SKIP_VALGRIND=0; SKIP_MYSQL=0;
}

# installed programs checker.                                            
prog_validator()
{
	FILE1=/$HOME/.git-credentials
	COUNTER=0;

	# -------------------------------
	CHECK=$(betty --version);
	if [[ $SKIP_BETTY = 0 ]];
	then
		if [[ "$CHECK" == *"version"* ]];
		then
			BETTY_STAT="INSTALLED";
			BETTY_P="${GREEN}INSTALLED${NC}";
		else
			BETTY_STAT="NOT FOUND";
			BETTY_P="${RED}NOT FOUND${NC}";
		fi
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
	CHECK=$(git --version);
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
	# -------------------------------
	CHECK=$(shellcheck --version);
	if [[ "$CHECK" == *"version"* ]];
	then
		SHELLCHECK_STAT="INSTALLED"
		SHELLCHECK_P="${GREEN}INSTALLED${NC}"
	else
		SHELLCHECK_STAT="NOT FOUND"
		SHELLCHECK_P="${RED}NOT FOUND${NC}"
	fi
	# -------------------------------
	CHECK=$(valgrind --version);
	if [[ "$CHECK" == *"valgrind"* ]];
	then
		VALGRIND_STAT="INSTALLED"
		VALGRIND_P="${GREEN}INSTALLED${NC}"
	else
		VALGRIND_STAT="NOT FOUND"
		VALGRIND_P="${RED}NOT FOUND${NC}"
	fi
	# -------------------------------
	CHECK=$(mysql --version);
	if [[ "$CHECK" == *"Ver"* ]];
	then
		MYSQL_STAT="INSTALLED"
		MYSQL_P="${GREEN}INSTALLED${NC}"
	else
		MYSQL_STAT="NOT FOUND"
		MYSQL_P="${RED}NOT FOUND${NC}"
	fi
}

# 1. Betty "C" code style install proccess.                                            
install_betty()
{
	if [ $SKIP_BETTY = 0 ];
	then
		echo '1. Install Betty "C" code style validator ? (y/n)';
		read -r VAR1_BETTY;
		if [ "$VAR1_BETTY" == "y" ];
		then
			sudo apt-get update -y;
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
		elif [ "$VAR1_BETTY" == "n" ];
		then
			SKIP_BETTY=1;
			BETTY_STAT="SKIPPED";
			BETTY_P="${CYAN}SKIPPED${NC}";
		fi
	fi
}

# 2. Zsh Oh My ZSH shell.                                            
install_zsh()
{
	echo '2. Install Zsh (Oh my Zsh shell) ? (y/n)';
	read -r VAR1_ZSH;
	if [ "$VAR1_ZSH" == "y" ]; 
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
	elif [ "$VAR1_ZSH" == "n" ];
	then
		ZSH_P="${CYAN}SKIPPED${NC}"
	fi
}

install_git()
{
	echo '3. Install git ? (y/n)';
	read -r VAR1_GIT;
	if [ "$VAR1_GIT" == "y" ]; 
	then
		VAR1="n";
		sudo apt-get update;
		sudo apt-get install git;
		wait;
		clear;
		echo "**************************************";
		echo "     git successfully Installed...    ";
		echo "**************************************";
		sleep 2;
	elif [ "$VAR1_GIT" == "n" ];
	then
		GIT_P="${CYAN}SKIPPED${NC}"
	fi
}

install_git_credentials()
{
	echo '4. Install git credentials ? (y/n)';
	read -r VAR1_GITCRED;
	if [ "$VAR1_GITCRED" == "y" ]; 
	then
		VAR1="n";
		echo "";
		echo -e "*Please write your github ${GREEN}USER NAME${NC} account:";
		read -r GIT_USER;
		echo "";
		echo -e "*Please write your github ${GREEN}PASSWORD${NC} account:";
		read -r GIT_PASSW;
		echo "";
		echo -e "*Please write your github ${GREEN}EMAIL${NC} account:";
		read -r GIT_EMAIL;
		#git config --global user.name $GIT_USER;
		#git config --global user.email $GIT_EMAIL;
		#git config --global push.default matching
		# ----------------------------------------------------------------
		echo "[user]" > $HOME/.gitconfig
		echo "     name = $GIT_USER" >> $HOME/.gitconfig
		echo "     email = $GIT_EMAIL" >> $HOME/.gitconfig
		echo "[push]" >> $HOME/.gitconfig
		echo "     default = matching" >> $HOME/.gitconfig
		echo "[credential]" >> $HOME/.gitconfig
		echo "     helper = store" >> $HOME/.gitconfig
		# ----------------------------------------------------------------
		echo "https://$GIT_USER:$GIT_PASSW@github.com" >> $HOME/.git-credentials
		return;
		
		clear;
		echo "**************************************";
		echo "   Github Credentials installing...   ";
		echo "**************************************";
		sleep 2;
	elif [ "$VAR1_GITCRED" == "n" ];
	then
		GITCRED_P="${CYAN}SKIPPED${NC}"
	fi
}

install_shellcheck()
{
	echo '5. Install shellcheck script validator ? (y/n)';
	read -r VAR1_SHELLCHECK;
	if [ "$VAR1_SHELLCHECK" == "y" ]; 
	then
		VAR1="n";
		sudo apt-get update;
		sudo apt-get install shellcheck;
		wait;
		clear;
		echo "**************************************";
		echo "         shellcheck Installing...     ";
		echo "**************************************";
		sleep 2;
	elif [ "$VAR1_SHELLCHECK" == "n" ];
	then
		SHELLCHECK_P="${CYAN}SKIPPED${NC}"
	fi
}

install_valgrind()
{
	echo '6. Install valgrind memory tester ? (y/n)';
	read -r VAR1_VALGRIND;
	if [ "$VAR1_VALGRIND" == "y" ]; 
	then
		VAR1="n";
		sudo apt-get update;
		sudo apt-get install valgrind;
		wait;
		clear;
		echo "**************************************";
		echo "       Valgrind  Installing...        ";
		echo "**************************************";
		sleep 2;
	elif [ "$VAR1_VALGRIND" == "n" ];
	then
		VALGRIND_P="${CYAN}SKIPPED${NC}"
	fi
}

install_mysql()
{
	echo '7. Install mysql ? (y/n)';
	read -r VAR1_MYSQL;
	if [ "$VAR1_MYSQL" == "y" ]; 
	then
		VAR1="n";
		sudo apt-get update;
		sudo apt-get install mysql-server;
		wait;
		clear;
		echo "**************************************";
		echo "          MYSQL Installing...         ";
		echo "**************************************";
		sleep 2;
	elif [ "$VAR1_MYSQL" == "n" ];
	then
		MYSQL_P="${CYAN}SKIPPED${NC}"
	fi
}

# -----------------------------------------
# main program of the script (entry point).
# -----------------------------------------
ENDING="n";
color_settings;
skip_flags;
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

	elif [ "$GIT_STAT" == "NOT FOUND" ];
	then
		install_git;

	elif [ "$GITCRED_STAT" == "NOT FOUND" ];
	then
		install_git_credentials;

	elif [ "$SHELLCHECK_STAT" == "NOT FOUND" ];
		then
			install_shellcheck;

	elif [ "$VALGRIND_STAT" == "NOT FOUND" ];
		then
			install_valgrind;

	elif [ "$MYSQL_STAT" == "NOT FOUND" ];
		then
			install_mysql;

	else
		echo 	" Dear user, all the TOOLS are already installed.         ";
		echo 	"                                                         ";
		echo -e "   ${CYAN}*** IMPORTANT: Zsh program will require your ***${NC}     ";
		echo -e "   ${CYAN}*** authorization after this script ENDs. ***${NC}        ";
		echo 	"                                                         ";
		echo 	" Do you want to EXIT now ? --- (y/n)                     ";
		echo 	"*********************************************************";
		read -r ENDING
	fi
	prog_validator;
done
cls;
sh ohmyzsh/tools/install.sh
