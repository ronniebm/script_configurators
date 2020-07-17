#!/usr/bin/env bash
PROGRAM_LIST=(
	betty
	zsh
	git
	shellcheck
	valgrind
	mysql
	vim
)
declare -A VAR_DICT
for i in ${PROGRAM_LIST[@]}
do
	VAR_DICT["$i"]="$(echo "$i"_p | tr a-z A-Z)"
done

#VAR_list +=("$(echo "$i_stat" | tr [a-z] [A-Z])")

for j in ${VAR_DICT[@]}
do
	echo "$j"
done