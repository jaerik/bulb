#!/bin/sh -eu

croak() {
	echo "ERROR: $*" >&2
	exit 1
}

bark() {
	echo "WARNING: $*" >&2
}

get_absolut_path() {
	l_path=${1:-}
	case $l_path in
		/*)
			l_absolut_path=$l_path
			;;
		./*)
			l_absolut_path="$PWD${l_path#.*}"
			;;
		*/*)
			l_absolut_path="$PWD/$l_path"
			;;
		*)
			l_absolut_path="$PWD/$l_path"
			;;
	esac
	echo $l_absolut_path
}
