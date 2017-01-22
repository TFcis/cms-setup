#! /bin/bash
ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
curl "http://dev.tfcis.org/cms/cmsconf.php?showthis&ip="$ip
echo ""
