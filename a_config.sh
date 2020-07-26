#!/usr/bin/env bash
#----- program list for be install in the run script-----------
PROGRAM_LIST=(
	betty
	git
	git_config
	shellcheck
	valgrind
	mysql
	vim
	emacs
	zsh
)
#--------auto generate var prompt dict (only for bash v4.0.0 or high------------
declare -A PROMP_DICT
for i in "${PROGRAM_LIST[@]}"
do
	PROMP_DICT["$i"]="NA"
done

#--------auto generate var control dict (only for bash v4.0.0 or high----------
declare -A CTRL_DICT
for i in "${PROGRAM_LIST[@]}"
do
	CTRL_DICT["$i"]+="NA"
done

# function that handles command-not-found message.
command_not_found_handle()
{
return 127;
}

# ---------user prompt message.------------
prompt()
{
	clear;
	echo 	'*********************************************************';
	echo	'*   My personal configurator v1.0  - for HOLBIES        *';
	echo 	'*                                                       *';
	echo  '*   Developed by:                                       *';
	echo 	'*                                                       *';
	echo -e	'*      \033[0;32mRonnie Barrios\033[0m  &  \033[0;32mJose Vallejo\033[0m (COLOMBIA)       *';
	echo 	'* ===================================================== *';
	echo -e	'* use it by your OWN RISK, tested: \033[1;35mUBUNTU: 14, 18, 20.\033[0m  *';
	echo 	'*                                                       *';
	echo -e	'* \033[1;35mGithub:\033[0m ronniebm          \033[1;35mE:\033[0m ronnie.coding@gmail.com  *';
	echo -e	'* \033[1;35mGithub:\033[0m josevallejo1984   \033[1;35mE:\033[0m josevallejo25@gmail.com  *';
	echo 	'* ----------------------------------------------------- *';
	echo 	'*                                                       *';
#echo 	'*  0. Automatic Installation                            *';
# ------ Autogenerate prompt -------------------------------------------------
	len=${#PROGRAM_LIST[@]}
	for ((i=0; i<"$len"; i++))
	do
		tool="${PROGRAM_LIST[i]}"
		tool_state="${PROMP_DICT["$tool"]}"
		echo -e "*  "$i"."$tool"\t.......................[ "$tool_state" ]    *";

	done

	echo '*                                                       *';
	echo '*********************************************************';
	echo '';
}

# color settings
color_settings()
{
	RED="\033[0;31m"; GREEN="\033[0;32m"; CYAN="\033[0;36m";
	YELLOW="\033[1;33m"; WHITE="\033[1;37m"; NC="\033[0m";
}

skip_flags()
{
	BETTY_SKIP=0; ZSH_SKIP=0; GIT_SKIP=0; GITCRED_SKIP=0;
	SHELLCHECK_SKIP=0; VALGRIND_SKIP=0; MYSQL_SKIP=0;
	VIM_SKIP=0; EMACS_SKIP=0;
}

# installed programs checker.
function prog_validator()
{
	FILE1=/$HOME/.git-credentials
	COUNTER=0
	RED="\033[0;31m"
	GREEN="\033[0;32m"
	NC="\033[0m"
	len=${#PROGRAM_LIST[@]}

	for ((i=0; i<"$len"; i++))
	do
		tool="${PROGRAM_LIST[i]}"
		tool_stat="${CTRL_DICT["$tool"]}"
		if [ "$tool_stat" != "SKIPPED" ]
		then
			if [ -e "$(which "$tool")" ];
			then
				CTRL_DICT["$tool"]="INSTALLED";
				PROMP_DICT["$tool"]="${GREEN}INSTALLED${NC}";
			else
				if [ -e "$HOME/.git-credentials" ] && [ "$tool" == "git_config" ]
				then
					CTRL_DICT["$tool"]="INSTALLED";
					PROMP_DICT["$tool"]="${GREEN}INSTALLED${NC}";
				else
					CTRL_DICT["$tool"]="NOT FOUND";
					PROMP_DICT["$tool"]="${RED}NOT FOUND${NC}";
				fi

			fi
		fi
	done
}

# 0. SUDO Install.
function install_sudo()
{
	if [ -e "$(which "sudo")" ];
	then
		return;
	else
		apt install sudo;
	fi
}

# 1. Betty "C" code style install proccess.
function install_betty()
{
	if [ "${CTRL_DICT["betty"]}" != "SKIPPED" ]
	then
		echo 'Install Betty "C" code style validator ? (y/n)';
		read -r VAR1_BETTY;
		if [ "$VAR1_BETTY" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			wait;
			git clone https://github.com/holbertonschool/Betty.git;
			wait;
			echo '*******************************************';
			echo 'preparing for installation proccess. wait !';
			echo '*******************************************';
			sleep 2;
			cd $PWD/Betty;
			source ./install.sh;
			sudo -y cp assets/scripts_config/betty /bin/;
			rm -rf $PWD/Betty;
		elif [ "$VAR1_BETTY" == "n" ];
		then
			CTRL_DICT["betty"]="SKIPPED"
			PROMP_DICT["betty"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 2. Zsh Oh My ZSH shell.
function install_zsh()
{
	if [ "${CTRL_DICT["zsh"]}" != "SKIPPED" ];
	then
		echo 'Install Zsh (Oh my Zsh shell) ? (y/n)';
		read -r VAR1_ZSH;
		if [ "$VAR1_ZSH" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y zsh;
			wait
			git clone https://github.com/ohmyzsh/ohmyzsh.git;
			chmod u+x $PWD/oh-my-zsh/tools/install.sh;
			clear;
			echo "**************************************";
			echo "  Zsh Shell successfully Installed... ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_ZSH" == "n" ];
		then
			CTRL_DICT["zsh"]="SKIPPED"
			PROMP_DICT["zsh"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 3. git installation.
function install_git()
{
	if [ "${CTRL_DICT["git"]}" != "SKIPPED" ];
	then
		echo 'Install git ? (y/n)';
		read -r VAR1_GIT;
		if [ "$VAR1_GIT" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y git;
			wait;
			clear;
			echo "**************************************";
			echo "     git successfully Installed...    ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_GIT" == "n" ];
		then
			CTRL_DICT["git"]="SKIPPED"
			PROMP_DICT["git"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 4. git_credentials installation.
function install_git_config()
{
	if [ "${CTRL_DICT["git_config"]}" != "SKIPPED" ];
	then
		echo 'Install git credential helper ? (y/n)';
		read -r VAR1_GITCRED;
		if [ "$VAR1_GITCRED" == "y" ];
		then
			install_sudo;
			wait;
			echo "";
			echo -e "*Please write your github ${GREEN}USER NAME${NC} account:";
			read -r GIT_USER;
			echo "";
			echo -e "*Please write your github ${GREEN}PASSWORD${NC} account:";
			read -r GIT_PASSW;
			echo "";
			echo -e "*Please write your github ${GREEN}EMAIL${NC} account:";
			read -r GIT_EMAIL;
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
			CTRL_DICT["git_config"]="SKIPPED"
			PROMP_DICT["git_config"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 5. shellcheck installation.
function install_shellcheck()
{
	if [ "${CTRL_DICT["shellcheck"]}" != "SKIPPED" ];
	then
		echo 'Install shellcheck script validator ? (y/n)';
		read -r VAR1_SHELLCHECK;
		if [ "$VAR1_SHELLCHECK" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y shellcheck;
			wait;
			clear;
			echo "**************************************";
			echo "         shellcheck Installing...     ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_SHELLCHECK" == "n" ];
		then
			CTRL_DICT["shellcheck"]="SKIPPED"
			PROMP_DICT["shellcheck"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 6. valgrind installation.
function install_valgrind()
{
	if [ "${CTRL_DICT["valgrind"]}" != "SKIPPED" ];
	then
		echo 'Install valgrind memory tester ? (y/n)';
		read -r VAR1_VALGRIND;
		if [ "$VAR1_VALGRIND" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y valgrind;
			wait;
			clear;
			echo "**************************************";
			echo "       Valgrind  Installing...        ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_VALGRIND" == "n" ];
		then
			CTRL_DICT["valgrind"]="SKIPPED"
			PROMP_DICT["valgrind"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 7. MYSQL installation.
function install_mysql()
{
	if [ "${CTRL_DICT["mysql"]}" != "SKIPPED" ];
	then
		echo 'Install mysql ? (y/n)';
		read -r VAR1_MYSQL;
		if [ "$VAR1_MYSQL" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y mysql-server;
			wait;
			clear;
			echo "**************************************";
			echo "          MYSQL Installing...         ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_MYSQL" == "n" ];
		then
			CTRL_DICT["mysql"]="SKIPPED"
			PROMP_DICT["mysql"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 8. VIM installation.
function install_vim()
{
	if [ "${CTRL_DICT["vim"]}" != "SKIPPED" ];
	then
		echo 'Install VIM [customized] ? (y/n)';
		read -r VAR1_VIM;
		if [ "$VAR1_VIM" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y vim;
			wait;
			git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
			wait;
			sudo rm "$HOME/.vimrc";
			sudo cp "assets/scripts_config/.vimrc" "$HOME/.vimrc";
			sudo vim +PluginInstall +qall;
			clear;
			echo "**************************************";
			echo "           VIM Installing...          ";
			echo "**************************************";
			sleep 2;
		elif [ "$VAR1_VIM" == "n" ];
		then
			CTRL_DICT["vim"]="SKIPPED"
			PROMP_DICT["vim"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# 9. EMACS installation.
function install_emacs()
{
	if [ "${CTRL_DICT["emacs"]}" != "SKIPPED" ];
	then
		echo 'Install EMACS [customized] ? (y/n)';
		read -r VAR1_EMACS;
		if [ "$VAR1_EMACS" == "y" ];
		then
			install_sudo;
			wait;
			sudo apt-get update -y;
			sudo apt-get install -y emacs;
			wait;
			sh $PWD/assets/scripts_config/emacs.sh;
			wait;
		elif [ "$VAR1_EMACS" == "n" ];
		then
			CTRL_DICT["emacs"]="SKIPPED"
			PROMP_DICT["emacs"]="${CYAN} SKIPPED ${NC}";
		fi
	fi
}

# -----------------------------------------
# main program of the script (entry point).
# -----------------------------------------
# ------ Autogenerate prompt -------------------------------------------------
color_settings;
prog_validator;
prompt

len="${#PROGRAM_LIST[@]}"

for ((i=0; i<"$len"; i++))
do
	tool="${PROGRAM_LIST["$i"]}"
	tool_stat="${CTRL_DICT["$tool"]}"
	if [ "$tool_stat" == "NOT FOUND" ]
	then
		install_"$tool"
	fi
	echo "$(prog_validator; prompt)"
done
ENDING="n";
while [ "$ENDING" == "n" ];
do
	echo 	" Dear user, all the TOOLS are already installed.         ";
	echo 	"                                                         ";
	echo -e "   ${CYAN}*** IMPORTANT: Zsh program will require your ***${NC}     ";
	echo -e "   ${CYAN}*** authorization after this script ENDs. ***${NC}        ";
	echo 	"                                                         ";
	echo 	" Do you want to EXIT now ? --- (y/n)                     ";
	echo 	"*********************************************************";
	read -r ENDING
done

cls;
if [ -e "$PWD/ohmyzsh/tools/install.sh" ]
then
    sh $PWD/ohmyzsh/tools/install.sh;
fi
