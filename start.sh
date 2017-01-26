#! /bin/bash
if [ "${1}" == "" ]
then
	echo "missing operand c=[CONTEST]"
else
	ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
	echo "This machine ip is "$ip

	for service in LogService ResourceService ScoringService Checker Worker AdminWebServer PrintingService TestFileCacher
	do
		echo $service
		start=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getstart&ip="$ip"&start="$service)
		count=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getcount&ip="$ip"&count="$service)
		if [ "${start}" != "-1" ]; then
			for (( i=$start; i<$start+$count; i++ ))
			do
				sudo cms$service $i &
				echo "cms"$service" "$i
			done
		fi
	done

	for service in EvaluationService ContestWebServer ProxyService
	do
		echo $service
		start=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getstart&ip="$ip"&start="$service)
		count=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getcount&ip="$ip"&count="$service)
		if [ "${start}" != "-1" ]; then
			for (( i=$start; i<$start+$count; i++ ))
			do
				sudo cms$service $i -c $1 &
				echo "cms"$service" "$i
			done
		fi
	done
fi
