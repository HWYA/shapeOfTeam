#!/bin/bash

output_array=($(git remote 2>&1))

h="heroku"
u="upstream"
o="origin"

h_remote="git remote add heroku https://git.heroku.com/shapeofteam.git"
u_remote="git remote add upstream https://git@github.com:HWYA/shapeOfTeam.git"

if  [ ${#output_array[@]} == 3 ]; then
	for remote in "${output_array[@]}"
	do
		echo $remote "remote is already present"
	done
elif [ ${#output_array[@]} == 2 ]; then
	for remote in "${output_array[@]}"
	do
		if [ "$remote" == $o ]; then
			unset output_array[$remote]
		fi
	done

	if [ ${output_array[@]} = $u ]; then
		$h_remote
		echo "heroku remote added!"
	else
		$u_remote
		echo "upstream remote added!"
	fi
fi