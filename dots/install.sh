#!/bin/bash

detect_os() {
	case $(uname -s) in
		darwin|Darwin) echo "darwin" ;;
		linux|Linux) echo "linux" ;;
		*) echo "unknown" ;;
	esac
}
readonly CWD=$(pwd -P)
readonly OSNAME=$(detect_os)


to_dot() {
	sed 's/^_/./'
}

install_to_home() {
	local from=$1
	local file=$(basename $from)
	local to=${HOME}/tmp/sandbox/$(echo $file | to_dot)

	[ -r ${to} ] && echo "skipping... $file already exists" && return 1
	echo "placing $file" && ln -sv $from $to
	# echo "placing $file" && echo ln -s $from $to
}

files=(
	"${CWD}/${OSNAME}/_bash_profile"
	"${CWD}/${OSNAME}/_bashrc"
	"${CWD}/${OSNAME}/_bash_alias"
	"${CWD}/_vim"
	"${CWD}/_tmux.conf"
	"${CWD}/_gitconfig"
	"${CWD}/_globalignore"
)

for file in ${files[@]}
do
	install_to_home $file
done
