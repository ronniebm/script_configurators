#!/usr/bin/env bash
PROGRAM_LIST=(
	betty
	zsh
	git
	shellcheck
	valgrind
	mysql
	vim
	emacs
	caracoles
	ereslomeju
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
	RED="\033[0;31m"
	GREEN="\033[0;32m"
	NC="\033[0m"
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

			else
				CTRL_DICT["${PROGRAM_LIST[i]}"]="NOT FOUND";
				PROMP_DICT["${PROGRAM_LIST[i]}"]="${RED}NOT FOUND${NC}";
			fi
		fi
	done
}

function prompt_two()
{
len=${#PROGRAM_LIST[@]}
clear;
echo 	'*********************************************************';
echo 	'* My personal configurator v1.0 (by Ronnie B.M. Jose V) *';
echo 	'* ===================================================== *';
echo 	'* use it by your OWN RISK, tested on UBUNTU 18 bionic   *';
echo 	'* bash v4.0                                             *';
echo 	'* Github: ronniebm,  Email: ronnie.coding@gmail.com     *';
echo 	'* ----------------------------------------------------- *';
echo 	'*                                                       *';
echo 	'*  0. Automatic Installation                            *';

for ((i=0; i<"$len"; i++))
do
	tool="${PROGRAM_LIST[i]}"
	tool_state="${PROMP_DICT["$tool"]}"
	echo -e "*  "$i"."$tool"\t.......................[ "$tool_state" ]    *";

done

echo 	'*                                                       *';
echo 	'*********************************************************';
echo 	'';
}


prog_validator
prompt_two
