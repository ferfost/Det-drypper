#!/bin/bash

level='l4'

getNextName() {
	local name=$(sed -e 's/ /%20/g' <<< "$1")
	curl -s -X POST https://apmgui.dripstat.com/rest/$level/game/lb?name=$name | jsawk 'lb = this.lb; next = null; if(lb.length > 2) { next = lb[1]; } else { next = lb[0]; }; return next.name + "&" + next.score + "&" + next.rank'
}

getThisName() {
	local name=$(sed -e 's/ /%20/g' <<< "$1")
	curl -s -X POST https://apmgui.dripstat.com/rest/$level/game/lb?name=$name | jsawk 'lb = this.lb; next = null; if(lb.length > 2) { next = lb[2]; } else { next = lb[1]; }; return next.name + "&" + next.score + "&" + next.rank'
}

main() {
	IFS='&'
	local reference=${1:-'bottom'}
	local line aline name score rank
	name=$reference
	line=$(getThisName "$name")
	echo $line
	#list="$list\n"$(tr '&' ' ' <<< "$line")

	while [[ $rank -ne 1 ]]; do

		line=$(getNextName "$name")
		echo $line
		#list="$list\n"$(tr '&' ' ' <<< "$line")
		aline=( $line )
		name=${aline[0]}
		score=${aline[1]}
		rank=${aline[2]}
	done
	
	#echo -e "$list"
}

ctrl_c() {
	#echo -e "$list"
	exit 1
}

list=''
trap ctrl_c INT

main "$@"; exit 0;