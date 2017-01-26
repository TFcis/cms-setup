#! /bin/bash
ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
if [ "${1}" == "" ]
then
	curl -s "http://dev.tfcis.org/cms/cmsconf.php?setservice&ip="$ip"&service=w&count=4"
	curl -s "http://dev.tfcis.org/cms/cmsconf.php?setservice&ip="$ip"&service=r&count=1"
else
	curl -s "http://dev.tfcis.org/cms/cmsconf.php?setservice&ip="$ip"&service="$1"&count="$2
fi
