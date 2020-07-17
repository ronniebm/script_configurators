#!/usr/bin/env bash
clear
PROGRAM_LIST=(
	betty
	zsh
	git
	shellcheck
	valgrind
	mysql
	vim
	emacs
)
#--------auto generate var promp dict (only for bash v4.0.0 or high------------
declare -A PROMP_DICT
for i in ${PROGRAM_LIST[@]}
do
	PROMP_DICT["$i"]="NA"
done

#--------auto generate var control dict (only for bash v4.0.0 or high----------
declare -A CTRL_DICT
for i in ${PROGRAM_LIST[@]}
do
	CTRL_DICT["$i"]+="NA"
done


function prog_validator()
{
	FILE1=/$HOME/.git-credentials
	COUNTER=0
	BETTY_SKIP=0
	len=${#PROGRAM_LIST[@]}

	for ((i=0; i<"$len"; i++))
	do
	# -------------------------------
		#CHECK=$("$PROGRAM_LIST[i]" --version);
		#echo "valor de i es: = $i"
		if [ $BETTY_SKIP = 0 ];
		then
			if [ -e "$(which "${PROGRAM_LIST[i]}")" ];
			then
				CTRL_DICT["${PROGRAM_LIST[i]}"]="INSTALLED";
				PROMP_DICT["${PROGRAM_LIST[i]}"]="${GREEN}INSTALLED${NC}";
				echo "match"

			else
				CTRL_DICT["${PROGRAM_LIST[i]}"]="NOT FOUND";
				PROMP_DICT["${PROGRAM_LIST[i]}"]="${RED}NOT FOUND${NC}";
				echo "NO match "${PROGRAM_LIST[0]}" "
			fi
		fi
	done
}

function prompt()
{
#clear;
echo 	'*********************************************************';
echo 	'*   My personal configurator v1.0 (by Ronnie B.M.)      *';
echo 	'* ===================================================== *';
echo 	'* use it by your OWN RISK, tested on UBUNTU 18 bionic   *';
echo 	'*                                                       *';
echo 	'* Github: ronniebm,  Email: ronnie.coding@gmail.com     *';
echo 	'* ----------------------------------------------------- *';
echo 	'*                                                       *';
echo 	'*  0. Automatic Installation                            *';
echo -e "*  1. betty (C code style validator) ..[ "${PROMP_DICT[betty]}" ]    *";
echo -e "*  2. zsh (Oh my Zsh shell) ...........[ "${PROMP_DICT[zsh]}" ]    *";
echo -e "*  3. git .............................[ "${PROMP_DICT[git]}" ]    *";
echo -e "*  5. shellcheck validator ............[ "${PROMP_DICT[shellcheck]}" ]    *";
echo -e	"*  6. valgrind memory tester ..........[ "${PROMP_DICT[valgrind]}" ]    *";
echo -e	"*  7. MYSQL database ..................[ "${PROMP_DICT[mysql]}" ]    *";
echo -e	"*  8. VIM   [customized] ..............[ "${PROMP_DICT[vim]}" ]    *";
echo -e	"*  9. EMACS [customized] ..............[ "${PROMP_DICT[emacs]}" ]    *";
echo 	'*                                                       *';
echo 	'*********************************************************';
echo 	'';
}

prog_validator
prompt

