#! /bin/bash
ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
curl -s "http://dev.tfcis.org/cms/cmsconf.php?record&ip="$ip"&message="$1
