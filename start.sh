#! /bin/bash
ip=$(ifconfig | grep -Po "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -1)
worker=$(curl http://dev.tfcis.org/cms/ip2worker.php?ip=$ip)
rs=$(curl http://dev.tfcis.org/cms/ip2rs.php?ip=$ip)
echo "This machine ip="$ip" Worker="$worker","$(($worker+1))","$(($worker+2))","$(($worker+3))" ResourceService="$rs
sudo cmsWorker $worker &
sudo cmsWorker $(($worker+1)) &
sudo cmsWorker $(($worker+2)) &
sudo cmsWorker $(($worker+3)) &
sudo cmsResourceService $rs
