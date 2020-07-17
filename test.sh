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
VAR_LIST=()
for i in ${PROGRAM_LIST[@]}
do
	VAR_LIST+=("$(echo "$i"_stat | tr a-z A-Z)")
	VAR_LIST+=("$(echo "$i"_p | tr a-z A-Z)")
done

#VAR_list +=("$(echo "$i_stat" | tr [a-z] [A-Z])")

for j in ${VAR_LIST[@]}
do
	echo "$j"
done