#! /bin/bash
ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
echo "This machine ip is "$ip

for service in LogService ResourceService ScoringService Checker EvaluationService Worker ContestWebServer AdminWebServer ProxyService PrintingService TestFileCacher
do
	start=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getstart&ip="$ip"&start="$service)
	count=$(curl -s "http://dev.tfcis.org/cms/cmsconf.php?getcount&ip="$ip"&count="$service)
	if [ "${start}" != "-1" ]; then
		for (( i=$start; i<$start+$count; i++ ))
		do
			echo $service" "$i
		done
	fi
done
echo ""
