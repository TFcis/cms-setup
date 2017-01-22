#! /bin/bash
curl "http://dev.tfcis.org/cms/cmsconf.php?make"
sudo rm ~/cms/config/cms.conf
sudo wget http://dev.tfcis.org/cms/cms.conf -P ~/cms/config/

cd ~/cms
sudo ./setup.py build
sudo ./setup.py install
sudo cmsInitDB
